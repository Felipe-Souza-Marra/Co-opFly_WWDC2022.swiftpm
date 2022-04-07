import SpriteKit

public class Pilot: SKSpriteNode, Aircraft {
    
    var velocity: CGFloat?
    
    var body: SKPhysicsBody?
    
    public init(type: TypeAircraft) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        
        let image = self.defineType(type: type)
        
        self.texture = image.texture
        
        self.size = image.size
        
        self.body = self.addPhysics(texture: self.texture!, size: self.size)
        
        self.zPosition = ZPositions.aircraft
        
        self.velocity = self.defineVelocity(type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
