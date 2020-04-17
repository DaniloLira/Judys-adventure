import Foundation
import UIKit

public class Notebook{
    
    public var view: UIButton = UIButton()
    public var aliensPage: UIImageView = UIImageView()
    public var discoverysPage: UIView = UserDefaults.standard.object(forKey: "Descobertas") == nil ? UIView() : UserDefaults.standard.object(forKey: "Descobertas") as! UIView
    public var discoverysTitle: UILabel = UILabel()
    
    var aliensButton: UIButton = UIButton()
    var discoverysButton: UIButton = UIButton()
    
    public init() {
        let cfURL = Bundle.main.url(forResource: "fontes/IndieFlower-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        self.view.isUserInteractionEnabled = true
        self.view.frame = CGRect(x: 1, y: 1, width: 900, height: 900)
        self.view.isHidden = true
        self.view.setBackgroundImage(UIImage(named: "cadernos/Caderno aberto"), for: .normal)
        self.view.addTarget(self, action: #selector(close), for: .touchUpInside)
        self.view.adjustsImageWhenHighlighted = false
        
        self.aliensPage.frame = CGRect(x: 170, y: 60, width: 516, height: 760)
        self.aliensPage.image = UIImage(named: "cadernos/Pagina alien")
        
        self.discoverysPage.frame = CGRect(x: 110, y: 30, width: 255, height: 385)
        
        self.discoverysTitle.frame = CGRect(x: 120, y: 50, width: 420, height: 70)
        self.discoverysTitle.font = UIFont(name: "IndieFlower", size: 47)
        self.discoverysTitle.textColor = .black
        self.discoverysTitle.text = "Anotações de Viagem"
        
        self.aliensButton.frame = CGRect(x: 689, y: 70, width: 40, height: 120)
        self.aliensButton.setBackgroundImage(UIImage(named: "Alienigena"), for: .normal)
        self.aliensButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        self.aliensButton.tag = 0
        
        self.discoverysButton.frame = CGRect(x: 700, y: 220, width: 40, height: 120)
        self.discoverysButton.setBackgroundImage(UIImage(named: "Descobertas"), for: .normal)
        self.discoverysButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        self.discoverysButton.tag = 1
        
        self.discoverysPage.addSubview(discoverysTitle)
        
        self.view.addSubview(discoverysPage)
        self.view.addSubview(aliensPage)
        self.view.addSubview(aliensButton)
        self.view.addSubview(discoverysButton)
    }
    
    @objc func close(){
        self.view.isHidden = true
    }
    @objc func nextPage(sender: UIButton){
        if sender.tag == 0{
            self.aliensButton.frame.origin.x = 689
            self.discoverysButton.frame.origin.x = 700
            self.aliensPage.isHidden = false
            self.discoverysPage.isHidden = true
        } else {
            self.aliensButton.frame.origin.x = 700
            self.discoverysButton.frame.origin.x = 689
            self.aliensPage.isHidden = true
            self.discoverysPage.isHidden = false
        }
        
    }
}
