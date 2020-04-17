import UIKit
import PlaygroundSupport

public class MyViewController : UIViewController {
    let canvas: Canvas = Canvas(size: 7)
    let notebook: Notebook = Notebook()
    let dice: Dice = Dice()
    let talkPopUp: Talk = Talk()
    var discoveries: [Discovery] = []
    let throwDice: UIButton = UIButton()
    let background: UIImageView = UIImageView()
    let hearts: [UIImageView] = [UIImageView(), UIImageView(), UIImageView()]
    let shiftsLeft: UILabel = UILabel()
    let stepsLeft: UILabel = UILabel()
    let shiftsFont: Font = Font(title: "Turnos Restantes: ", number: UserDefaults.standard.integer(forKey: "shiftsLeft") == 0 ? "5": String(UserDefaults.standard.integer(forKey: "shiftsLeft")), color: UIColor.green)
    let stepsFont: Font = Font(title: "Passos Restantes: ", number: String(UserDefaults.standard.integer(forKey: "steps")), color: UIColor.red)
    let discoverysTitle: UILabel = UILabel()
    let lifes: UIImageView = UIImageView()
    let notebookButton: UIButton = UIButton()
    let correctAnswerText: UIImageView = UIImageView(image: UIImage(named: "Resposta Certa"))
    var shifts: Int = UserDefaults.standard.integer(forKey: "shiftsLeft") == 0 ? 6 : UserDefaults.standard.integer(forKey: "shiftsLeft")
    var heartsValue: Int = UserDefaults.standard.integer(forKey: "heartsValue") == 0 ? 4 : UserDefaults.standard.integer(forKey: "heartsValue")
    var answer: Int = 27778
    var discoveriesTexts: [String : [String]] = UserDefaults.standard.object(forKey: "descobertas") as? [String : [String]] ?? [String:  [String]]()
    
    override public func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 900, height: 900))
        self.view = view
        
        var cfURL = Bundle.main.url(forResource: "fontes/FjallaOne-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        view.addSubview(background)
        view.addSubview(canvas)
        view.addSubview(dice.view)
        view.addSubview(shiftsLeft)
        view.addSubview(stepsLeft)
        view.addSubview(discoverysTitle)
        view.addSubview(throwDice)
        view.addSubview(notebookButton)
        view.addSubview(notebook.view)
        view.addSubview(talkPopUp)
        
        
        generateTiles()
        generateETs()
        
        view.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleRightMargin]
        
        background.frame = CGRect(x: 0, y: 0, width: 900, height: 900)
        background.image = UIImage(named: "Background")
        
        throwDice.setBackgroundImage(UIImage(named: "Botão"), for: .normal)
        throwDice.frame = CGRect(x: 38, y: 852, width: 190, height: 55)
        throwDice.addTarget(self, action: #selector(MyViewController.throwDiceFunc), for: .touchUpInside)
        
        if heartsValue >= 2 {
            for i in 2...heartsValue {
                let h = i - 2
                hearts[h].image = UIImage(named: "Coração")
                hearts[h].frame = CGRect(x: 31.0 + Double(50 * h), y: 18.0, width: 49.89, height: 39.35)
                view.addSubview(hearts[h])
            }
        }


        notebookButton.frame = CGRect(x: 680, y: 710, width: 150, height: 183)
        notebookButton.setImage(UIImage(named: "cadernos/Caderno Pequeno"), for: .normal)
        notebookButton.addTarget(self, action: #selector(openNotebook), for: .touchUpInside)
        
        shiftsLeft.attributedText = shiftsFont.get()
        shiftsLeft.frame = CGRect(x: 321, y: 8, width: 238, height: 60)

        stepsLeft.attributedText = stepsFont.get()
        stepsLeft.frame = CGRect(x: 641, y: 18, width: 232, height: 43)

        loadDiscoveries()
        self.talkPopUp.buttonGetNote.addTarget(self, action: #selector(getNote), for: .touchUpInside)
        
        correctAnswerText.frame = CGRect(x: 0, y: 0, width: 900, height: 900)
        correctAnswerText.isHidden = true
        view.addSubview(correctAnswerText)
    }
    
    @objc func getNote(){
        self.talkPopUp.isHidden = true
        self.notebook.discoverysPage.isHidden = false
        self.notebook.aliensPage.isHidden = true
        self.notebook.view.isHidden = false
    }
    func generateTiles(){
        self.canvas.addTile(x: 0, y: 5, start: true)
        self.canvas.addTile(x: 1, y: 5)
        self.canvas.addTile(x: 2, y: 5)
        self.canvas.addTile(x: 3, y: 5)
        self.canvas.addTile(x: 4, y: 5)
        self.canvas.addTile(x: 4, y: 4)
        self.canvas.addTile(x: 4, y: 3)
        self.canvas.addTile(x: 5, y: 3)
        self.canvas.addTile(x: 5, y: 2)
        self.canvas.addTile(x: 4, y: 3)
        self.canvas.addTile(x: 3, y: 3)
        self.canvas.addTile(x: 2, y: 3)
        self.canvas.addTile(x: 2, y: 4)
        self.canvas.addTile(x: 2, y: 2)
        self.canvas.addTile(x: 0, y: 2)
        self.canvas.addTile(x: 1, y: 2)
        self.canvas.addTile(x: 0, y: 1)
        self.canvas.addTile(x: 2, y: 1)
        self.canvas.addTile(x: 5, y: 5)

    }
    
    func generateETs(){
        let ets: [Alien] = [
            Alien(x: 5, y: 2, text: "Q = m * v", color: "amarelo"),
            Alien(x: 5, y: 2, text: "ΔS = V * ΔT", color: "amarelo"),
            Alien(x: 2, y: 1, text: "É mais fácil parar uma bola de tênis a 20km/h do que um carro com a mesma velocidade por causa da diferença de quantidade de movimento", color: "roxo"),
            Alien(x: 0, y: 1, text: "A quantidade de movimento(Q) inicial é igual à final", color: "verde"),
            Alien(x: 1, y: 1, text: "O foguete se move em velocidade constante após a propulsão", color: "verde")
        ]
        
        for et in ets{
            if let node = self.canvas.nodes[et.x][et.y] {
                node.addAlien(et)
                et.addTarget(self, action: #selector(clickET), for: .touchUpInside)
                self.canvas.addSubview(et)
            }

        }
    }
    
    @objc func clickET(alien: Alien){
        alien.isEnabled = false
        self.talk(to: alien)
        self.talkPopUp.textAnimation(face: alien.face, givenText: alien.text)
    }
    
    @objc func openNotebook(){
        notebook.view.isHidden = false
    }
    
    @objc func throwDiceFunc(){
        self.dice.roll()
        self.canvas.steps = self.dice.currentValue
        self.shifts -= 1
        self.shiftsFont.number = String(self.shifts - 1)
        self.stepsFont.number = String(self.canvas.steps)
        self.stepsLeft.attributedText = stepsFont.get()
        self.shiftsLeft.attributedText = shiftsFont.get()
        
        if self.shifts == 1 {
            self.throwDice.isEnabled = false
        }
        
        UserDefaults.standard.set(shifts, forKey: "shiftsLeft")
    }
    
    
    @objc func talk(to alien: Alien){
        if !alien.didTalk{
            let discovery = Discovery(text: alien.text, color: alien.color)
            
            if self.discoveries.count > 0 {
                if self.discoveries.count%2 == 0{
                    discovery.setPosition(x: 110, y: self.discoveries.last!.view.frame.minY + 220)
                } else {
                    discovery.setPosition(x: 340, y: self.discoveries.last!.view.frame.minY)
                }
            }
            
            self.notebook.discoverysPage.addSubview(discovery.view)
            self.discoveries.append(discovery)
            self.discoveriesTexts[alien.text] = [alien.text, alien.color]
            
            UserDefaults.standard.set(discoveriesTexts, forKey: "descobertas")
            alien.didTalk = true
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        self.canvas.bringSubviewToFront(self.canvas.judy)
    }
    
    public func loadDiscoveries(){
        for (alien, discoveryContent) in self.discoveriesTexts {
            let discovery = Discovery(text: discoveryContent[0], color: discoveryContent[1])

            if self.discoveries.count > 0 {
                if self.discoveries.count%2 == 0{
                    discovery.setPosition(x: 110, y: self.discoveries.last!.view.frame.minY + 220)
                } else {
                    discovery.setPosition(x: 340, y: self.discoveries.last!.view.frame.minY)
                }
            }

            self.notebook.discoverysPage.addSubview(discovery.view)
            self.discoveries.append(discovery)
        }
    }
    
    public func responder(_ resposta: Int?){
        if let tentativa = resposta{
            if tentativa == self.answer {
                self.correctAnswerText.isHidden = false
            } else {
                self.heartsValue -= 1
                self.talkPopUp.textAnimation(face: UIImage(named: "Cabeça Judy")!, givenText: "Opa, parece que isso não deu certo", context: 1)
                UserDefaults.standard.set(heartsValue, forKey: "heartsValue")
            }
        }
    }
}
