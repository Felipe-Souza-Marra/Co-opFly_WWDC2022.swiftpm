//
//  File.swift
//  
//
//  Created by Felipe Souza Marra on 11/04/22.
//

enum GameFinishedType {
    
    case lost
    case win
    
}

import SpriteKit

class GameFinished: SKScene, AutoLayout {
    
    var type: GameFinishedType
    
    var label: SKLabelNode?
    
    init(size: CGSize, type: GameFinishedType) {
        self.type = type
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.backgroundColor = .clear
        
        switch type {
        case .lost:
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
            
            addChild(label!)
        case .win:
            let background = Background(texture: nil, color: .white, size: self.size)
            background.zPosition = 0
            background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            
            addChild(background)
            
            let spriteEnd = SKSpriteNode(texture: SKTexture(imageNamed: "Passed"))
            
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
            label?.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.15)
            
            addChild(label!)
            
            let label1 = SKLabelNode()
            
            

            label1.fontName = FontsCustom.font1
            label1.horizontalAlignmentMode = .center
            label1.verticalAlignmentMode = .center
            label1.text = "You were able to help the pilot dodge the traffic."
            
            let attrString = NSMutableAttributedString(string: label1.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let range = NSRange(location: 0, length: label1.text!.count)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
            attrString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.init(name: FontsCustom.font1, size: height * 0.04)!], range: range)
            label1.attributedText = attrString
            
            label1.zPosition = 2
            label1.fontSize = height * 0.04
            label1.fontColor = .black
            label1.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.3)
            label1.preferredMaxLayoutWidth = width * 0.9
            label1.lineBreakMode = .byTruncatingMiddle
            label1.numberOfLines = 2
            
            self.addChild(label1)
            
        }
        
        
        
    }
    
    override func didMove(to view: SKView) {
        label?.run(.repeatForever(.sequence([
            .fadeIn(withDuration: 1),
            .fadeOut(withDuration: 1)
        ])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.presentScene(GameScene(size: CGSize(width: width, height: height), cutSceneSkiped: true), transition: .fade(withDuration: 1))
    }
    
}
