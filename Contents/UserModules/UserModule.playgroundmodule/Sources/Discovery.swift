import Foundation
import UIKit

public class Discovery{
    public var view: UIImageView = UIImageView()
    public var textLabel: UILabel = UILabel()
    
    public init(text: String, color: String) {
        self.textLabel.text = text
        self.textLabel.numberOfLines = 15
        self.textLabel.frame = CGRect(x: 15, y: 15, width: 170, height: 137)
        self.textLabel.textColor = .black
        self.textLabel.textAlignment = .center
        self.textLabel.font = UIFont(name: "FjallaOne-Regular", size: 14)

        
        self.view.addSubview(self.textLabel)
        self.view.frame = CGRect(x: 110, y: 150, width: 200, height: 188)
        self.view.image = UIImage(named: "postits/" + color)
    }
    
    public func setPosition(x: CGFloat, y: CGFloat){
        self.view.frame = CGRect(x: x, y: y, width: 200, height: 188)
    }
}
