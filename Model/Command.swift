import SpriteKit

public enum CommandType {
    
    case up
    case down
    case left
    case right
    
}

public class Command: SKLabelNode {
    
    private var onState = false
    
    private var command: String
    
    private var type: CommandType
    
    public init(_ command: String, type: CommandType) {
        
        self.command = command
        
        self.type = type
        
        super.init()
        
        self.fontSize = UIScreen.main.bounds.size.height * 0.035
        
        self.zPosition = ZPositions.hud
        
        self.isUserInteractionEnabled = true
        
        self.verticalAlignmentMode = .center
        
        self.text = self.command
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.checkState()
        
        if let parent = self.parent as? Commands {
            switch self.type {
            case .up:
                if parent.down.onState {
                    parent.down.checkState()
                }
            case .down:
                if parent.up.onState {
                    parent.up.checkState()
                }
            case .left:
                if parent.right.onState {
                    parent.right.checkState()
                }
            case .right:
                if parent.left.onState {
                    parent.left.checkState()
                }
            }
        }
    }
    
    public func checkState() {
        
        if self.onState {
            self.text = command
            self.onState = false
        }
        else {
            if type == .up || type == .down {
                self.text = "Normal speed"
            }
            else {
                self.text = "Center"
            }
            self.onState = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
