import SpriteKit

public class HUD: SKNode {
    
    let shape = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    public override init() {
        super.init()
        shape.strokeColor = .clear
//        shape.fillColor = .blue
        shape.zPosition = 10
        
        add(shape)
    }
    
    public func add(_ node: SKNode, x: CGFloat? = nil, y: CGFloat?  = nil) {
        node.position.x = x == nil ? self.shape.position.x: x!
        node.position.y = y == nil ? self.shape.position.y: y!
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
