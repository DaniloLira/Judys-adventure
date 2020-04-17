import Foundation
import UIKit

public class Alien: UIButton{
    public var text: String
    public var side: String
    public var x: Int
    public var y: Int
    public var didTalk: Bool = false
    public var face: UIImage = UIImage(named: "Cabeca Verde")!
    public var color: String
    
    public init(side: String = "baixo", x: Int, y: Int, text: String, color: String) {
        self.text = text
        self.side = side
        self.x = x
        self.y = y
        self.color = color
        
        super.init(frame: CGRect(x: x * 62 + 5, y: y * 62 - 80, width: 50, height: 120))
        self.isEnabled = false
        self.adjustsImageWhenDisabled = false
        
        
        switch color{
        case "amarelo":
            self.face = UIImage(named: "Cabeca Amarelo")!
            self.setBackgroundImage(UIImage(named: "ET Amarelo")!, for: .normal)
            self.frame.size.width = 66
            self.frame.origin.x = CGFloat(x * 62 - 3)
        case "roxo":
            self.face = UIImage(named: "Cabeca Roxo")!
            self.setBackgroundImage(UIImage(named: "ET Roxo")!, for: .normal)
            self.frame.size.width = 71
            self.frame.origin.x = CGFloat(x * 62)
        case "verde":
            self.face = UIImage(named: "Cabeca Verde")!
            self.setBackgroundImage(UIImage(named: "ET Verde")!, for: .normal)
            self.frame.size.width = 50
        default: break
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
