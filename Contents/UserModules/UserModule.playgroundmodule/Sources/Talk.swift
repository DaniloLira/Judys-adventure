import Foundation
import UIKit

public class Talk: UIImageView{
    public var text: UILabel = UILabel()
    public var alienFace: UIImageView = UIImageView()
    public var buttonGetNote: UIButton = UIButton()
    
    public init() {
        self.alienFace.frame = CGRect(x: 400, y: 300, width: 100, height: 116)
        
        self.text.frame = CGRect(x: 220, y: 400, width: 460, height: 120)
        self.text.numberOfLines = 10
        self.text.textColor = .white
        self.text.font = UIFont(name: "FjallaOne-Regular", size: 16)
        
        self.buttonGetNote.setBackgroundImage(UIImage(named: "Anotar")!, for: .normal)
        self.buttonGetNote.frame = CGRect(x: 320, y: 530, width: 261, height: 54)
        
        super.init(frame: CGRect(x: 0, y: 0, width: 483, height: 450))
        
        self.frame = CGRect(x: 0, y: 0, width: 900, height: 900)
        self.isUserInteractionEnabled = true
        self.isHidden = true
        self.image = UIImage(named: "Popup")!
        
        self.addSubview(self.text)
        self.addSubview(self.alienFace)
        self.addSubview(buttonGetNote)
    }
    
    public func textAnimation(face: UIImage, givenText: String, context: Int = 0){
        if context == 0 {
            self.buttonGetNote.setBackgroundImage(UIImage(named: "Anotar")!, for: .normal)
        } else {
           self.buttonGetNote.setBackgroundImage(UIImage(named: "Rever")!, for: .normal)
        }
        
        self.alienFace.image = face
        self.isHidden = false
        var partialText = ""
        for c in givenText{
            partialText += "\(c)"
            self.text.text = partialText
            RunLoop.current.run(until: Date()+0.05)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
