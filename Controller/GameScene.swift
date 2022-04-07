import SpriteKit
import CoreGraphics

public class GameScene: SKScene, AutoLayout {
    
    var hud: HUD?
    
    var cameraNode: SKCameraNode?
    
    var interativeChat: InteractiveChat?
    
    var aircraft: [OtherAircraft] = []
    
    public override init(size: CGSize) {
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
        
        let aircraft1 = OtherAircraft(type: .airplane, direction: .left)
        let aircraft2 = OtherAircraft(type: .pilot, direction: .right)
        let aircraft3 = OtherAircraft(type: .freighter, direction: .left)
        
        self.aircraft.append(aircraft1)
        self.aircraft.append(aircraft2)
        self.aircraft.append(aircraft3)
        
        aircraft1.position.x += 100
        aircraft2.position.x -= 100
        aircraft3.position.x += 100
        
        aircraft1.position.y += 100
        aircraft3.position.y -= 100
        
        addChild(aircraft1)
        addChild(aircraft2)
        addChild(aircraft3)
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition1 = Transmission(.sender, message: "Opa, Rafinha")

        self.interativeChat?.addTransmission(transition1)
        
    }
    
    public override func didMove(to view: SKView) {
        self.interativeChat?.addTransmission(Transmission(.reciver, message: "Oisdasdasdasdasda"))
    }
    
    public override func update(_ currentTime: TimeInterval) {
        self.interativeChat?.update(dt: currentTime)
        self.cameraNode?.position.y += 2
        for aircraft in self.aircraft {
            aircraft.update(dt: currentTime)
        }
    }
    
    
    
}
