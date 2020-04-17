import UIKit
import PlaygroundSupport

public class Font {
    public var title: String
    public var number: String
    public var color: UIColor
    public init(title: String, number: String, color: UIColor){
        let cfURL = Bundle.main.url(forResource: "fontes/IndieFlower-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        self.title = title
        self.number = number
        self.color = color
    }
    
    public func get() -> NSMutableAttributedString{
        let colorAttribute = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 25) ]
        
        let shiftsLeftText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 25)])
        let shiftsText = NSAttributedString(string: number, attributes: colorAttribute)
        let finalShifts = NSMutableAttributedString()
        
        finalShifts.append(shiftsLeftText)
        finalShifts.append(shiftsText)
        
        return finalShifts
    }
}
