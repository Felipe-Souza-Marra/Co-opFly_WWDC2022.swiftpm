import SpriteKit

public class Commands: SKSpriteNode {
    
//    var up: Command = Command("Accelerate now", type: CommandType.up)
    var down: Command
    var left: Command
    var right: Command
    public override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        self.down = Command("Slow down now", type: CommandType.down, size: CGSize(width: size.width * 0.4, height: size.height))
        self.left = Command("Turn left", type: CommandType.left, size: CGSize(width: size.width * 0.3, height: size.height))
        self.right = Command("Turn right", type: CommandType.right, size: CGSize(width: size.width * 0.3, height: size.height))
        
        super.init(texture: texture, color: color, size: size)
        
        self.name = "Commands"
        
        self.zPosition = ZPositions.hud
        
        self.right.position.x += UIScreen.main.bounds.size.width * 0.35
        self.left.position.x -= UIScreen.main.bounds.size.width * 0.35
        
//        self.addChild(self.up)
        self.addChild(self.down)
        self.addChild(self.left)
        self.addChild(self.right)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
