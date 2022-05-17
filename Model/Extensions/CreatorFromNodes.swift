import SpriteKit
import GameplayKit

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
        
        self.commands = commands
        
        hud.add(commands, x: 0 , y: -(height/2) + commands.size.height/2)
        
        //Adicionando Piloto
        
        cameraNode.addChild(self.createPilot())
        
        return cameraNode
        
        
    }
    
}

//MARK: Aircrafts

extension GameScene {
    
    /// Function within the scene to create the pilot.
    /// - Returns: The main pilot.
    public func createPilot() -> SKSpriteNode {
        let pilot = Pilot(type: .pilot)
        
        self.pilot = pilot
        
        pilot.position.y -= height * 0.7
        
        return pilot
        
    }
    
    public func createOtherAircraft() -> OtherAircraft {
        
        let aircraft: OtherAircraft
        let type: TypeAircraft
        let direction: Direction
        
        switch self.returnIntRandom() {
        case 1...50:
            direction = .left
        default:
            direction = .right
        }
        
        switch self.returnIntRandom() {
        case 1...50:
            type = .airplane
        default:
            type = .freighter
        }
        
        aircraft = OtherAircraft(type: type, direction: direction)
        
        switch type {
        case .pilot:
            aircraft.body?.categoryBitMask = CategoryMaskPhysics.smallAircraft
        case .airplane:
            aircraft.body?.categoryBitMask = CategoryMaskPhysics.mediumAircraft
        case .freighter:
            aircraft.body?.categoryBitMask = CategoryMaskPhysics.bigAircraft
        }
        
        let x: CGFloat , y: CGFloat
        
        switch self.returnIntRandom() {
        case 1...20:
            x = width * 0.5 * -(aircraft.direction!)
            y = (self.cameraNode?.position.y)! + height * 0.5
        case 21...60:
            x = width * 0.5 * -(aircraft.direction!) * 1.5
            y = (self.cameraNode?.position.y)! + height * 0.7
        default:
            x = width * 0.5 * -(aircraft.direction!) * 1.2
            y = (self.cameraNode?.position.y)! + height * 0.6
        }
        
        aircraft.position = CGPoint(x: x, y: y)
        
        self.aircraft.append(aircraft)
        
        return aircraft
        
    }
    
    
    /// Function within the scene that returns a cloud.
    /// - Returns: A Cloud.
    func createCloud() -> Cloud {
        
        let cloud: CloudAbove
        
        cloud = CloudAbove()
        
        cloud.position.y = cameraNode!.position.y + (height * 0.8) + (cloud.size.height/2)
        
        return cloud
        
    }
    
}
