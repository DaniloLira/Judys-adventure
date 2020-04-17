import Foundation
import UIKit

public class Node: UIButton{
    public var visited = false
    public var alien: Alien? = nil
    public var connections: [Connection] = []
    public var coordinate: (Int, Int)
    
    public init(x: Int, y: Int){
        let positionX = (x * 62)
        let positionY = (y * 62)
        self.coordinate = (x, y)
        super.init(frame: CGRect(x: positionX, y: positionY, width: 60, height: 60))
        self.setBackgroundImage(UIImage(named: "Piso"), for: .normal)
        self.adjustsImageWhenDisabled = false
    }
    
    public func addAlien(_ alien: Alien){
        self.alien = alien
        self.isEnabled = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class Connection {
    public let to: Node
    public let weight: Int = 1
    
    public init(to node: Node) {
        self.to = node
    }
}

public class Path {
    public let cumulativeWeight: Int
    public let node: Node
    public let previousPath: Path?
    public var path: [Node] = []
    
    public init(to node: Node, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if let previousPath = path, let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
            self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
    }

    public func getPath(totalPath: [(Int,Int)]) -> [(Int, Int)]{
        var varTotalPath = totalPath
        
        if let path = self.previousPath {
            varTotalPath.insert(self.node.coordinate, at: 0)
            return path.getPath(totalPath: varTotalPath)
        }
        
        return varTotalPath
    }
}
