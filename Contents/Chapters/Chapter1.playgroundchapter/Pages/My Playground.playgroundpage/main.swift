/*:

 # Judy Adventures
 
 ## O que é Judy Adventures?
 É um jogo que estimula o estudo de física a partir de questões contextualizadas com o mundo de Judy. Ele é um aventureiro espacial, que busca conhecimento para vencer os desafios que aparecem, para isso conta com os ETs que encontra em suas viagens.
 
 ## Modo de Jogar
 Jogue o dado para saber o número de passos possíveis num turno. Um turno é uma jogada do dado. Use seus passos para se mover até os ETs e conversar com eles, obtendo novos conhecimentos e com isso ajudar Judy a vencer o desafio. Quando você achar que tem a resposta para o desafio, digite no campo de **resposta**. Você pode ler o caderno de Judy a qualquer momento do jogo para rever suas anotações e a diferença entre os ETs.
 Para reiniciar a fase é preciso chamar a função:  **reiniciar()**
 
 
 ## Primeiro Desafio
 ![Judy](Fase_1-3.png)
 
 O foguete de Judy quebrou no planeta Mercúpiter, e assim que ele terminou de consertar, deu partida novamente para seguir seu rumo. Ele precisa saber se vai chegar a tempo de almoçar com sua mãe em Jupturno. Para isso precisa descobrir qual a **velocidade** do seu foguete, considerando que ele solta um motor de **100.000kg** a **50.000km/h** de velocidade e que seu foguete pesa inicialmente **180.000kg**.
 
*/


//#-hidden-code
import UIKit
import PlaygroundSupport

public func reiniciar(){
    let ud = UserDefaults.standard
    ud.removeObject(forKey: "heartsValue")
    ud.removeObject(forKey: "JudyX")
    ud.removeObject(forKey: "JudyY")
    ud.removeObject(forKey: "shiftsLeft")
    ud.removeObject(forKey: "steps")
    ud.removeObject(forKey: "descobertas")
    ud.removeObject(forKey: "JudySide")
    ud.removeObject(forKey: "diceSide")
}
 
var resposta: Int?
//#-end-hidden-code

//#-editable-code
resposta = nil
//reiniciar()
//#-end-editable-code
    
//#-hidden-code
let jogo = MyViewController()
PlaygroundPage.current.liveView = jogo
jogo.responder(resposta)

//#-end-hidden-code


