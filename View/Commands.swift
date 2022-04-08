import SpriteKit

public class Commands: SKSpriteNode {
    
    var up: Command = Command("Accelerate now", type: CommandType.up)
    var down: Command = Command("Slow down now", type: CommandType.down)
    var left: Command = Command("Turn left", type: CommandType.left)
    var right: Command = Command("Turn right", type: CommandType.right)
    
    public override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        super.init(texture: texture, color: color, size: size)
        
        self.zPosition = ZPositions.hud
        
        self.up.position.y += UIScreen.main.bounds.size.height * 0.045
        self.down.position.y -= UIScreen.main.bounds.size.height * 0.045
        
        self.right.position.x += UIScreen.main.bounds.size.width * 0.3
        self.left.position.x -= UIScreen.main.bounds.size.width * 0.3
        
        self.addChild(self.up)
        self.addChild(self.down)
        self.addChild(self.left)
        self.addChild(self.right)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
