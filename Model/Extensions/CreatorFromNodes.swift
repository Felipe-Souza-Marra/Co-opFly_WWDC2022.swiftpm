import SpriteKit

//MARK: SKCameraNode

extension GameScene {
    
    func createCamera() -> SKCameraNode {
        let cameraNode = SKCameraNode()
        
        self.cameraNode = cameraNode
        
        //Adicionando HUD
        
        let hud = HUD()
        
        self.hud = hud
        
        //Adicionando Interactive Chat
        
        let interactiveChat = InteractiveChat(texture: nil, color: UIColor.clear)
        
        self.interativeChat = interactiveChat
        
        print(width)
        
        hud.add(interactiveChat, x: 0, y: (height/2) - interactiveChat.size.height/2)
        cameraNode.addChild(hud)
        
        //Adicionando BackGround
        
        let background = Background(texture: nil, color: UIColor.init(rgb: 0x8393CB), size: CGSize(width: width, height: height))
                
        hud.addChild(background)
        
        //Adicionando Commands Labels
        
        let commands = Commands(texture: nil, color: UIColor.black, size: CGSize(width: width, height: height * 0.15))
        
        hud.add(commands, x: 0 , y: -(height/2) + commands.size.height/2)
        
        //Adicionando Piloto
        
        cameraNode.addChild(self.createPilot())
        
        return cameraNode
        
        
    }
    
}

//MARK: Aircrafts

extension GameScene {
    
    public func createPilot() -> SKSpriteNode {
        let pilot = Pilot(type: .pilot)
        
        pilot.position.y -= 160
        
        return pilot
        
    }
    
}
