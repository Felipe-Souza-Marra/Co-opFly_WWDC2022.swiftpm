import SpriteKit

public class OtherAircraft: SKSpriteNode, Aircraft {
    
    public init(type: TypeAircraft, direction: Direction) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        
        let type = self.defineType(type: type)
        
        self.texture = type.texture
        
        self.size = type.size
        
        self.zPosition = ZPositions.aircraft
        
        self.defineDirection(direction: direction)
        
    }
    
    private func defineDirection(direction: Direction) {
        
        switch direction {
        case .left:
            self.zRotation = (90/360 * 2 * Double.pi)
        case .right:
            self.zRotation = -(90/360 * 2 * Double.pi)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
