import SpriteKit

public class Pilot: SKSpriteNode, Aircraft {
    
    var velocity: CGFloat?
    
    var body: SKPhysicsBody?
    
    public init(type: TypeAircraft) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0, height: 0))
        self.name = "Pilot"
        let image = self.defineType(type: type)
        
        self.texture = image.texture
        
        self.size = image.size
        
        self.body = self.addPhysics(texture: self.texture!, size: self.size)
        
        self.physicsBody = body
        
        self.zPosition = ZPositions.aircraft
        
        self.velocity = self.defineVelocity(type: type)
        
        self.addChild(self.addAudio())
        
    }
    
    public func addAudio() -> SKAudioNode {
        let audio = SKAudioNode(fileNamed: "AudioAeronave.wav")
        
        audio.autoplayLooped = true
        audio.isPositional = true
        audio.run(.changeVolume(by: 0.01, duration: 0))
        
        return audio
    }
    
    /// The confirmation for the aircraft to continue with the correct action.
    /// - Parameters:
    ///   - type: The command type.
    ///   - actived: String for checking the next change.
    public func executeAction(type: CommandType, actived: String) {
        
        guard let scene = self.scene as? GameScene else { return }
        
        if let commands = scene.hud?.childNode(withName: "Commands") as? Commands {
            switch type {
            case .up:
                if actived != "Normal speed" {
                    self.velocity = Velocity.pilot * (height / 1366)
                }
                else {
                    self.velocity = 1.5 * (Velocity.pilot * (height / 1366))
                }
            case .down:
                if actived != "Normal speed" {
                    self.velocity = Velocity.pilot * (height / 1366)
                }
                else {
                    self.velocity = 0.8 * (Velocity.pilot * (height / 1366))
                }
            case .left:
                if actived != "Center" {
                    self.run(.moveTo(x: 0, duration: 0.5))
                }
                else {
                    if (commands.right.isOnState() == .on) {
                        self.run(.moveTo(x: -(width * 0.25) , duration: 1.5))
                    } else {
                        self.run(.moveTo(x: -(width * 0.25) , duration: 0.5))
                    }
                }
            case .right:
                if actived != "Center" {
                    self.run(.moveTo(x: 0, duration: 0.5))
                }
                else {
                    if (commands.left.isOnState() == .on) {
                        self.run(.moveTo(x: width * 0.25 , duration: 1.5))
                    } else {
                        self.run(.moveTo(x: width * 0.25 , duration: 0.5))
                    }
                    
                }
            case .pilot:
                break
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
