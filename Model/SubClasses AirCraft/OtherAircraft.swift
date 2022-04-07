import SpriteKit

public class OtherAircraft: SKSpriteNode, Aircraft {
    
    var velocity: CGFloat?
    
    var direction: CGFloat?
    
    var body: SKPhysicsBody?
    
    public init(type: TypeAircraft, direction: Direction) {
        
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        
        self.direction = self.defineDirection(direction: direction)
        
        self.velocity = self.defineVelocity(type: type)
        
        let image = self.defineType(type: type)
        
        self.texture = image.texture
        
        self.size = image.size
        
        self.body = self.addPhysics(texture: self.texture!, size: self.size)
        
        self.zPosition = ZPositions.aircraft
        
    }
    
    private func defineDirection(direction: Direction) -> CGFloat {
        
        switch direction {
        case .left:
            self.zRotation = (90/360 * 2 * Double.pi)
            return -1
        case .right:
            self.zRotation = -(90/360 * 2 * Double.pi)
            return 1
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(dt: TimeInterval) {
        self.position.x += (velocity! * direction!)
    }
    
}
