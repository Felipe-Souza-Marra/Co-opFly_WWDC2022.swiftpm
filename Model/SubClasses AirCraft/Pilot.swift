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
    
    public func executeAction(type: CommandType, actived: String) {
        
        switch type {
        case .up:
            if actived != "Normal speed" {
                self.velocity = 6 * (height / 1366)
            }
            else {
                self.velocity = 1.5 * (6 * (height / 1366))
            }
        case .down:
            if actived != "Normal speed" {
                self.velocity = 6 * (height / 1366)
            }
            else {
                self.velocity = 1.5 * (6 * (height / 1366))
            }
        case .left:
            if actived != "Center" {
                self.run(.moveTo(x: 0, duration: 0.5))
            }
            else {
                self.run(.moveTo(x: -(width * 0.25) , duration: 0.5))
            }
        case .right:
            if actived != "Center" {
                self.run(.moveTo(x: 0, duration: 0.5))
            }
            else {
                self.run(.moveTo(x: width * 0.25 , duration: 0.5))
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
