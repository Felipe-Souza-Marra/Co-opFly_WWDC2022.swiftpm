import SpriteKit

public class Pilot: SKSpriteNode, Aircraft {
    
    var body: SKPhysicsBody?
    
    public init(type: TypeAircraft) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        
        let type = self.defineType(type: type)
        
        self.texture = type.texture
        
        self.size = type.size
        
        self.body = self.addPhysics(texture: self.texture!, size: self.size)
        
        self.zPosition = ZPositions.aircraft
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
