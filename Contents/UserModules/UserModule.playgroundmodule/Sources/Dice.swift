import Foundation
import UIKit

public class Dice {
    public var view: UIImageView = UIImageView()
    public var currentValue: Int = 1
    
    public func roll(){
        self.animate()
        let number = Int.random(in: 1...6)
        let side = "dados/Dado" + String(number)
        self.view.image = UIImage(named: side)
        self.currentValue = number
        UserDefaults.standard.set(side, forKey: "diceSide")
    }
    
    public func animate(){
        self.view.startAnimating()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.frame.origin.y = 650
        }, completion: { finished in UIView.animate(withDuration: 0.5, animations: {
            self.view.frame.origin.y = 719
        }, completion: {finished in self.view.stopAnimating()})})
        
        

        
    }
    
    public init(){
        let diceSide: String? = UserDefaults.standard.string(forKey: "diceSide") as? String
        if let side = diceSide {
            self.view.image = UIImage(named: side)
        } else {
            self.view.image = UIImage(named: "dados/Dado1")
        }
        
        var spritesAnimation: [UIImage] = [UIImage(named: "dados/Dado1")!]
        for lado in 2...6{spritesAnimation.append(UIImage(named: "dados/Dado" + String(lado))!)}
        self.view.animationImages = spritesAnimation
        self.view.animationDuration = 0.6
        
        self.view.frame = CGRect(x: 70, y: 719, width: 120, height: 120)
    }
    
}

