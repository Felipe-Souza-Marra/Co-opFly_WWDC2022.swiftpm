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
    
    private var canSpawnAircraft: Bool = false
    
    private var cutSceneSkiped: Bool
    
    var timer: Int = 24 {
        
        willSet {
            if newValue == 2500 && cutSceneSkiped == true {
                self.isPaused = true
                self.view?.presentScene(GameFinished(size: self.size, type: .win), transition: .fade(withDuration: 3))
            }
        }
        
        didSet {
            self.updateScene(dt: timer)
        }
        
    }
    
    public init(size: CGSize, cutSceneSkiped: Bool) {
        self.cutSceneSkiped = cutSceneSkiped
        self.randomness = GKRandomDistribution(lowestValue: 1, highestValue: 100)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = .clear
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.physicsWorld.contactDelegate = self
        
        addChild(self.createCamera())
        self.listener =  pilot
        
        self.camera = self.cameraNode
        
    }
    
    public override func didMove(to view: SKView) {
        print(self.cutSceneSkiped)
        self.pilot?.run(.moveTo(y: (self.camera?.position.y)! - self.height * 0.25, duration: 2)) {
            self.animationStar()
        }
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
        
        switch (dt % 200) {
        case 50:
            addChild(self.createCloud() as! SKNode)
            if canSpawnAircraft {
                addChild(self.createOtherAircraft())
            }
        case 100:
            addChild(self.createCloud() as! SKNode)

            enumerateChildNodes(withName: "Cloud") { (node, _) in
                if let cloud = node as? CloudAbove {
                    cloud.offScreen()
                }
            }
        case 150:
            addChild(self.createCloud() as! SKNode)

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

//MARK: Animation Star

extension GameScene {
    
    func animationStar() {
        
        if cutSceneSkiped {
            
            self.commands?.down.setCanBeTight(true)
            self.commands?.left.setCanBeTight(true)
            self.commands?.right.setCanBeTight(true)
            self.run(.wait(forDuration: 2)) {
                self.canSpawnAircraft = true
                self.timer = 24
            }
            
        } else {
            self.run(.sequence([
                .run {
                    self.interativeChat?.addTransmission(Transmission(.reciver, message: "Mayday, Mayday, Mayday...", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 3.2),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.reciver, message: "Control Tower, UB22.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 2.7),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.sender, message: "UB22 go ahead.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.reciver, message: "Control tower this is UB22.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.reciver, message: "We have a GPS system failure.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.sender, message: "Aircraft UB22 Mayday, say your intentions.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4.7),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.reciver, message: "We request heading to a nearby airport.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.sender, message: "Understood UB22 Mayday.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.sender, message: "Your route has too many traffic.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4),
                .run {
                    self.interativeChat?.addTransmission(Transmission(.sender, message: "Follow our instructions for rerouting.", typeCommand: .pilot, oldStates: [self.commands!.down.isOnState(), self.commands!.left.isOnState(), self.commands!.right.isOnState()], action: {}))
                },
                .wait(forDuration: 4)
                
            ])) {
                self.commands?.down.setCanBeTight(true)
                self.commands?.left.setCanBeTight(true)
                self.commands?.right.setCanBeTight(true)
                self.run(.wait(forDuration: 2)) {
                    self.canSpawnAircraft = true
                    self.timer = 24
                    self.cutSceneSkiped = true
                }
            }
        }
        
    }
    
}
