//
//  File.swift
//  
//
//  Created by Felipe Souza Marra on 11/04/22.
//

import SpriteKit

class GameFinished: SKScene, AutoLayout {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        backgroundColor = .clear
        
        let background = Background(texture: nil, color: .white, size: self.size)
        
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        addChild(background)
        
        let spriteEnd = SKSpriteNode(texture: SKTexture(imageNamed: "Failure"))
        
        spriteEnd.zPosition = 1
        spriteEnd.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        spriteEnd.zRotation = (45/360 * 2 * Double.pi)
        
        
        addChild(spriteEnd)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.presentScene(GameScene(size: CGSize(width: width, height: height)), transition: .fade(withDuration: 1))
    }
    
}
