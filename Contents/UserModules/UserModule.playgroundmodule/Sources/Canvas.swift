import Foundation
import UIKit

public class Canvas: UIView {
    public var nodes: [[Node?]] = []
    public var judy: Astronaut = Astronaut()
    public var size: Int = 0
    public var steps: Int = UserDefaults.standard.integer(forKey: "steps")
    var textFont: Font = Font(title: "Passos Restantes: ", number: "5", color: UIColor.red)
    public init(size: Int) {
        super.init(frame: CGRect(x: 242, y: 250, width: size * 70, height: size * 70))
        let line = Array<Node?>(repeating: nil, count: size)
        self.nodes = Array<[Node?]>(repeating: line, count: size)
        self.size = size
        self.addSubview(judy)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addTile(x: Int, y: Int, start: Bool = false){
        let node = Node(x: x, y: y)
        node.addTarget(self, action: #selector(moveJudy), for: .touchUpInside)
        self.nodes[x][y] = node
        
        if start {
            let defaults = UserDefaults.standard
            if defaults.integer(forKey: "JudyX") != 0 || defaults.integer(forKey: "JudyY") != 0{
                self.judy.setPosition(x: defaults.integer(forKey: "JudyX"), y: defaults.integer(forKey: "JudyY"))
            } else {
                self.judy.setPosition(x: x, y: y)
            }
            
            
        }
        
        if x > 0 && self.nodes[x-1][y] != nil{
            node.connections.append(Connection(to: self.nodes[x-1][y]!))
            self.nodes[x-1][y]!.connections.append(Connection(to: node))
        }
        if x < size && self.nodes[x+1][y] != nil {
            node.connections.append(Connection(to: self.nodes[x+1][y]!))
            self.nodes[x+1][y]!.connections.append(Connection(to: node))
        }
        if y > 0 && self.nodes[x][y-1] != nil {
            node.connections.append(Connection(to: self.nodes[x][y-1]!))
            self.nodes[x][y-1]!.connections.append(Connection(to: node))
        }
        if y < size && self.nodes[x][y+1] != nil {
            node.connections.append(Connection(to: self.nodes[x][y+1]!))
            self.nodes[x][y+1]!.connections.append(Connection(to: node))
        }
        
        self.addSubview(node)
        self.bringSubviewToFront(judy)
    }
    
    @objc func moveJudy(sender: Node){
        let pathList = shortestPath(source: nodes[judy.x][judy.y]!, destination: sender)
        let path = pathList?.getPath(totalPath: [])
        
        if let stepsNeeded = pathList{
            if stepsNeeded.cumulativeWeight <= steps {
                if let way = path {
                    
                    judy.move(through: way)
                    
                    // Verificar se existe algum alien perto
                    let x = pathList!.node.coordinate.0
                    let y = pathList!.node.coordinate.1
                    
                    for posicao in [(x-1, y), (x+1, y), (x, y+1), (x, y-1)]{
                        if posicao.0 >= 0 && posicao.1 >= 0 {
                            if let node = self.nodes[posicao.0][posicao.1] {
                                if let alien = node.alien {
                                    alien.isEnabled = true
                                }
                            }
                        }

                    }
                }
                // Substrair os passos dados pelo total e atualizar a view
                steps -= stepsNeeded.cumulativeWeight
                textFont.number = String(steps)
                var stepsLabel = superview?.subviews[4] as! UILabel
                stepsLabel.attributedText = textFont.get()
                UserDefaults.standard.set(steps, forKey: "steps")
                
            }
            
        }

    }
    
    func shortestPath(source: Node, destination: Node) -> Path? {
        var frontier: [Path] = [] { didSet { frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } } }
        var visitedNodes: [Node] = []
        frontier.append(Path(to: source)) // the frontier is made by a path that starts nowhere and ends in the source
        
        while !frontier.isEmpty {
            let cheapestPathInFrontier = frontier.removeFirst() // getting the cheapest path available
            guard !cheapestPathInFrontier.node.visited else { continue } // making sure we haven't visited the node already
            
            if cheapestPathInFrontier.node === destination {
                for node in visitedNodes{ node.visited = false }
                return cheapestPathInFrontier // found the cheapest path 😎
            }
            
            cheapestPathInFrontier.node.visited = true
            visitedNodes.append(cheapestPathInFrontier.node)
            for connection in cheapestPathInFrontier.node.connections where !connection.to.visited { // adding new paths to our frontier
                frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
            }
        } // end while
        for node in visitedNodes{
            node.visited = false
        }
        return nil // we didn't find a path 😣
    }
}
