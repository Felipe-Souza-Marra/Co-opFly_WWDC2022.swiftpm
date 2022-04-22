import SpriteKit

public enum CommandType {
    
    case up
    case down
    case left
    case right
    case pilot
    
}

public enum CommandState {
    
    case on
    case off
    
}

public class Command: SKSpriteNode {
    
    private var label: SKLabelNode
    
    private var onState: CommandState {
        
        didSet {
            switch self.onState {
            case .on:
                if type == .up || type == .down {
                    self.label.text = "Normal speed"
                    self.changeString()
                }
                else {
                    self.label.text = "Center"
                    self.changeString()
                }
            case .off:
                self.label.text = command
                self.changeString()
            }
        }
        
    }
    
    private var command: String
    
    private var canBeTight: Bool = false {
        
        didSet {
            if self.canBeTight {
                self.run(.fadeIn(withDuration: 2))
            } else {
                self.run(.fadeOut(withDuration: 2))
            }
        }
        
    }
    
    private var type: CommandType
    
    public init(_ command: String, type: CommandType, size: CGSize) {
        
        self.onState = .off
        
        self.command = command
        
        self.type = type
        
        self.label = SKLabelNode()
        
        super.init(texture: nil, color: .clear, size: size)
        
        self.alpha = 0
        
        self.label.fontSize = UIScreen.main.bounds.size.height * 0.035
        
        self.label.fontName = FontsCustom.font1
        
        self.label.zPosition = ZPositions.hud
        
        self.isUserInteractionEnabled = true
        
        self.zPosition = ZPositions.hud
        
        self.label.verticalAlignmentMode = .center
        
        self.label.text = self.command
        
        self.changeString()
        
        self.label.preferredMaxLayoutWidth = self.size.width * 0.95
        self.label.lineBreakMode = .byTruncatingMiddle
        self.label.numberOfLines = 2
        
        self.label.fontColor = .white
        
        self.addChild(label)
        
    }
    
    public func changeString() {
        
        let attrString = NSMutableAttributedString(string: self.label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: self.label.text!.count)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.init(name: FontsCustom.font1, size: height * 0.035)!], range: range)
        self.label.attributedText = attrString
        
    }
    
    public func setCanBeTight(_ canBeTight: Bool) {
        self.canBeTight = canBeTight
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.transmittingMessage()
        
    }
    
    public func transmittingMessage() {
        
        guard self.canBeTight else { return }
        
        var text: String = ""
        var oldStates = [CommandState]()
        
        if let commands = self.parent as? Commands {
            
            oldStates.append(commands.down.onState)
            oldStates.append(commands.left.onState)
            oldStates.append(commands.right.onState)
            
            switch self.type {
            case .pilot:
                break
            case .up:
                
                //                if self.onState == .off {
                //                    text = "Speed up now."
                //                    self.setOnState(onState: .on)
                //                } else {
                //                    text = "Back to normal speed."
                //                    self.setOnState(onState: .off)
                //                }
                break
                
            case .down:
                
                if self.onState == .off {
                    text = "Slow down now."
                    self.setOnState(onState: .on)
                } else {
                    text = "Back to normal speed."
                    self.setOnState(onState: .off)
                }
                
            case .left:
                
                if commands.right.isOnState() == .on {
                    commands.right.setOnState(onState: .off)
                }
                
                if self.onState == .off {
                    text = "Turn Left."
                    self.setOnState(onState: .on)
                } else {
                    text = "Back to midle."
                    self.setOnState(onState: .off)
                }
                
            default:
                
                if commands.left.isOnState() == .on {
                    commands.left.setOnState(onState: .off)
                }
                
                if self.onState == .off {
                    text = "Turn Right."
                    self.setOnState(onState: .on)
                } else {
                    text = "Back to midle."
                    self.setOnState(onState: .off)
                }
            }
        }
        
        self.callCommand(text: text, oldStates: oldStates)
        
    }
    
    private func callCommand(text: String, oldStates: [CommandState]) {
        
        guard let scene = self.scene as? GameScene else { return }
        
        scene.interativeChat?.addTransmission(Transmission(.sender, message: text, typeCommand: self.type, oldStates: oldStates, action: {
            scene.pilot?.executeAction(type: self.type, actived: self.label.text!)
        }))
        
    }
    
    public func setOnState(onState: CommandState) {
        self.onState = onState
    }
    
    public func isOnState() -> CommandState {
        return self.onState
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
