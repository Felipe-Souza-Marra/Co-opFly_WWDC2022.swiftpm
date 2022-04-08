import SpriteKit
import CoreGraphics
import GameplayKit

public class GameScene: SKScene, AutoLayout, Randomness {
    
    var randomness: GKRandomDistribution
    
    var hud: HUD?
    
    var cameraNode: SKCameraNode?
    
    var interativeChat: InteractiveChat?
    
    var pilot: Pilot?
    
    var aircraft: [OtherAircraft] = []
    
    public override init(size: CGSize) {
        self.randomness = GKRandomDistribution(lowestValue: 0, highestValue: 100)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity.dy = -2
        
        addChild(self.createCamera())
        
        self.camera = self.cameraNode
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        self.interativeChat?.update(dt: currentTime)
        self.cameraNode?.position.y += self.pilot?.velocity ?? 0
        
        for aircraft in self.aircraft {
            aircraft.update(dt: currentTime)
        }
        
    }
    
    
    
}
