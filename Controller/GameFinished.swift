//
//  File.swift
//  
//
//  Created by Felipe Souza Marra on 11/04/22.
//

import SpriteKit

class GameFinished: SKScene, AutoLayout {
    
    var label: SKLabelNode?
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        backgroundColor = .clear
        
        let background = Background(texture: nil, color: .white, size: self.size)
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        addChild(background)
        
        let spriteEnd = SKSpriteNode(texture: SKTexture(imageNamed: "Failure"))
        
        let widthMultiplier = (width * 0.8) / spriteEnd.size.width
        
        spriteEnd.size = CGSize(width: spriteEnd.size.width * widthMultiplier, height: spriteEnd.size.height * widthMultiplier)
        
        spriteEnd.zPosition = 1
        spriteEnd.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.65)
        spriteEnd.zRotation = (35/360 * 2 * Double.pi)
        
        
        addChild(spriteEnd)
        
        label = SKLabelNode()
        
        label?.fontName = FontsCustom.font1
        label?.text = "Tap to screen to restart"
        label?.zPosition = 2
        label?.fontSize = height * 0.035
        label?.fontColor = .black
        label?.alpha = 0
        label?.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        
        dump(label)
        
        addChild(label!)
        
    }
    
    override func didMove(to view: SKView) {
        label?.run(.repeatForever(.sequence([
            .fadeIn(withDuration: 1),
            .fadeOut(withDuration: 1)
        ])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.presentScene(GameScene(size: CGSize(width: width, height: height)), transition: .fade(withDuration: 1))
    }
    
}
