import SpriteKit

public class InteractiveChat: SKSpriteNode {
    
    var waitMessageReciver: Transmission?
    
    var waitMessageSender: Transmission?
    
    private var messagesInChat: [Transmission?] = []
    
    public init(texture: SKTexture?, color: UIColor) {
        super.init(texture: texture, color: color, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height * 0.15))
        
        let background = SKShapeNode(rectOf: self.size)
        
        background.fillColor = .black
        background.alpha = 0.3
        background.zPosition = ZPositions.interactiveChat
        background.strokeColor = .clear
        
        self.addChild(background)
        
        
        self.zPosition = 2
    }
    
    public func addTransmission(_ transmission: Transmission) {
        
        switch transmission.type {
        case .sender:
            if waitMessageSender ==  nil {
                if messagesInChat.count == 2 {
                    self.messagesInChat[0]!.run(.moveTo(y: self.messagesInChat[0]!.position.y + self.messagesInChat[0]!.circleWithImage.frame.size.height * 1.8, duration: 0.2))
                    
                    self.messagesInChat[1]!.run(.moveTo(y: self.messagesInChat[1]!.position.y + self.messagesInChat[1]!.circleWithImage.frame.size.height * 1.2, duration: 0.2)){
                        transmission.position.y -= transmission.circleWithImage.frame.size.height * 0.6
                        self.messagesInChat.append(transmission)
                        self.waitMessageSender = transmission
                        self.addChild(transmission)
                        
                        self.messagesInChat[0]!.removeFromParent()
                        self.messagesInChat.removeFirst()
                        
                    }
                } else {
                    waitMessageSender = transmission
                }
            }
            else if waitMessageSender!.message.first != "." {
                waitMessageSender!.message = "..."
                waitMessageSender?.completeDialogue = false
                guard let scene = self.scene as? GameScene else { return }
                if let commands = scene.hud?.childNode(withName: "Commands") as? Commands {
                    commands.down.setOnState(onState: waitMessageSender!.oldStates.removeFirst())
                    commands.left.setOnState(onState: waitMessageSender!.oldStates.removeFirst())
                    commands.right.setOnState(onState: waitMessageSender!.oldStates.removeFirst())
                }
            }
        case .reciver:
            if waitMessageReciver ==  nil {
                if messagesInChat.count == 2 {
                    self.messagesInChat[0]!.run(.moveTo(y: self.messagesInChat[0]!.position.y + self.messagesInChat[0]!.circleWithImage.frame.size.height * 1.8, duration: 0.2))
                    
                    self.messagesInChat[1]!.run(.moveTo(y: self.messagesInChat[1]!.position.y + self.messagesInChat[1]!.circleWithImage.frame.size.height * 1.2, duration: 0.2)){
                        transmission.position.y -= transmission.circleWithImage.frame.size.height * 0.6
                        self.messagesInChat.append(transmission)
                        self.waitMessageReciver = transmission
                        self.addChild(transmission)
                        
                        self.messagesInChat[0]!.removeFromParent()
                        self.messagesInChat.removeFirst()
                        
                    }
                } else {
                    waitMessageReciver = transmission
                }
            }
            else if waitMessageReciver!.message.first != "." {
                waitMessageReciver!.message = "..."
                waitMessageReciver?.completeDialogue = false
            }
        }
        
    }
    
    public func controlMessage(_ transmission: Transmission?, dt: TimeInterval) {
        guard let message = transmission else {
            return
        }
        
        if message.message.isEmpty {
            if message.completeDialogue {
                message.action()
            }
            removeMessage(message.type)
        } else if !(message.inserted)  {
            message.inserted = true
            controlChat(message)
        }
        else {
            message.update(dt: dt)
        }
        
    }
    
    public func controlChat(_ transmission: Transmission) {
        
        switch self.messagesInChat.count {
        case 0:
            
            transmission.position.y += transmission.circleWithImage.frame.size.height * 0.6
            self.messagesInChat.append(transmission)
            addChild(transmission)
            
        case 1:
            
            transmission.position.y -= transmission.circleWithImage.frame.size.height * 0.6
            self.messagesInChat.append(transmission)
            addChild(transmission)
            
        default:
            break
            
        }
        
    }
    
    public func removeMessage(_ type: TypeTrasmisson) {
        
        switch type {
        case .reciver:
            waitMessageReciver = nil
        case .sender:
            waitMessageSender = nil
        }
        
    }
    
    public func update(dt: TimeInterval) {
        
        self.controlMessage(self.waitMessageReciver, dt: dt)
                            
        self.controlMessage(self.waitMessageSender, dt: dt)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
