import SpriteKit

public class OtherAircraft: SKSpriteNode, Aircraft {
    
    var velocity: CGFloat?
    
    var direction: CGFloat?
    
    var body: SKPhysicsBody?
    
    public init(type: TypeAircraft, direction: Direction) {
        
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        self.name = "OtherAircraft"
        
        self.direction = self.defineDirection(direction: direction)
        
        self.velocity = self.defineVelocity(type: type)
        
        let image = self.defineType(type: type)
        
        self.texture = image.texture
        
        self.size = image.size
        
        self.body = self.addPhysics(texture: self.texture!, size: self.size)
        
        self.physicsBody = body
        
        self.zPosition = ZPositions.aircraft
        
        self.addChild(self.addAudio())
        
    }
    
    public func addAudio() -> SKAudioNode {
        let audio = SKAudioNode(fileNamed: "AudioAeronave.wav")
        
        audio.autoplayLooped = true
        audio.isPositional = true
        audio.run(.changeVolume(by: 0.2, duration: 0))
        
        return audio
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
    
    /// Function to remove aircraft.
    func offScreen() {
        guard let scene = scene as? GameScene else { return }
        
        if scene.camera!.position.y > (self.position.y + ((self.width * 0.8) + self.size.height/2)) {
            
            self.removeFromParent()
            scene.aircraft.removeFirst()
            
        }
    }
    
    func update(dt: TimeInterval) {
        self.run(.moveTo(x: self.position.x + (velocity! * direction!), duration: 0))
    }
    
}
