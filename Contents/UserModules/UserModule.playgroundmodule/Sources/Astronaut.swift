import Foundation
import UIKit

public class Astronaut: UIImageView{
    public var side: String = "right"
    public var x: Int = 0
    public var y: Int = 0
    private var sprites: [String: [UIImage]] = [:]
    
    public func move(through: [(Int, Int)]){
        var path = through
        
        if through.count > 0 {
            if self.x < through[0].0{
                self.image = self.sprites["direita"]![0]
                self.animationImages = self.sprites["direita"]!
                UserDefaults.standard.set("judy/direita/1", forKey: "JudySide")
            } else if self.x > through[0].0{
                self.image = self.sprites["esquerda"]![0]
                self.animationImages = self.sprites["esquerda"]!
                UserDefaults.standard.set("judy/esquerda/1", forKey: "JudySide")
            } else if self.y > through[0].1{
                self.image = self.sprites["cima"]![5]
                self.animationImages = self.sprites["cima"]!
                UserDefaults.standard.set("judy/cima/1", forKey: "JudySide")
            } else {
                self.image = self.sprites["baixo"]![0]
                self.animationImages = self.sprites["baixo"]!
                UserDefaults.standard.set("judy/baixo/1", forKey: "JudySide")
            }
            
            self.x = path[0].0
            self.y = path[0].1
            
            UserDefaults.standard.set(self.x, forKey: "JudyX")
            UserDefaults.standard.set(self.y, forKey: "JudyY")
        }
        
        self.startAnimating()
        
        if through.count > 0{
            let coordinate = path.removeFirst()
            UIView.animate(withDuration: 0.5, animations: {
                self.frame.origin.x = CGFloat(coordinate.0) * 62 - 5
                self.frame.origin.y = CGFloat(coordinate.1) * 56 - 65
            }, completion: { finished in self.move(through: path)})
        } else {
            self.stopAnimating()
        }
    }
    
    public func turn(to: String){
        self.side = to
    }
    public func setPosition(x: Int, y: Int) {
        self.x = x
        self.y = y
        let positionX = (x * 62) - 5
        let positionY = (y * 56) - 65
        self.frame = CGRect(x: positionX, y: positionY, width: 70, height: 130)
    }
    
    public init() {
        super.init(frame: CGRect(x: 74, y: 74, width: 35, height: 65))
        var nameUD = UserDefaults.standard.string(forKey: "JudySide") as? String
        
        if let name = nameUD {
            self.image = UIImage(named: name)
        } else {
            self.image = UIImage(named: "judy/direita/1")
        }
        
        for lado in ["esquerda", "direita", "cima", "baixo"]{
            var sprites_lado: [UIImage] = []
            for i in 1...6{ sprites_lado.append(UIImage(named: "judy/\(lado)/\(i)" )!) }
            self.sprites[lado] = sprites_lado
        }
        self.animationDuration = 0.6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


