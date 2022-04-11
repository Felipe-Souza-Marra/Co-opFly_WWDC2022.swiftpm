import SpriteKit
import CoreGraphics
import GameplayKit

public class GameScene: SKScene, AutoLayout, Randomness {
    
    var randomness: GKRandomDistribution
    
    var hud: HUD?
    
    var commands: Commands?
    
    var cameraNode: SKCameraNode?
    
    var interativeChat: InteractiveChat?
    
    var pilot: Pilot?
    
    var aircraft: [OtherAircraft] = []
    
    var timer: Int = 74 {
        
        didSet {
            self.updateScene(dt: timer)
        }
        
    }
    
    public override init(size: CGSize) {
        self.randomness = GKRandomDistribution(lowestValue: 1, highestValue: 100)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = .clear
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity.dy = -2
        
        addChild(self.createCamera())
        
        self.camera = self.cameraNode
        
    }
    
    public override func didMove(to view: SKView) {
        self.commands?.down.setCanBeTight(true)
        self.commands?.left.setCanBeTight(true)
        self.commands?.right.setCanBeTight(true)
    }
    
    public override func update(_ currentTime: TimeInterval) {
        self.interativeChat?.update(dt: currentTime)
        self.cameraNode?.run(.moveTo(y: self.cameraNode!.position.y + self.pilot!.velocity!, duration: 0))
        
        for aircraft in self.aircraft {
            aircraft.update(dt: currentTime)
        }
        
        self.timer += 1;
        
    }
    
    public func updateScene(dt: Int) {
        
        switch (dt % 175) {
        case 75:
            addChild(self.createCloud() as! SKNode)
            addChild(self.createOtherAircraft())
        case 125:
            enumerateChildNodes(withName: "Cloud") { (node, _) in
                if let cloud = node as? CloudAbove {
                    cloud.offScreen()
                }
            }
        case 175:
            enumerateChildNodes(withName: "OtherAircraft") { (node, _) in
                if let cloud = node as? OtherAircraft {
                    cloud.offScreen()
                }
            }
        default:
            break
        }
        
    }
    
}
