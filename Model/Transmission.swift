import Foundation
import SpriteKit

public enum TypeTrasmisson {
    case reciver
    case sender
}

public class Transmission: SKSpriteNode {

    //MARK: Variável para lógica

    lazy var image: SKTexture = {
        let image = SKTexture(imageNamed: "")

        return image
    }()
    
    var index: Int = 0
    
    var timer: Int = 0
    
    var message: String {
        
        didSet {
            
            if message.count == 0 {
                self.legendSong.run(.stop())
            }
            
        }
        
    }
    
    var legendSong: SKAudioNode
    
    var typeCommand: CommandType
    
    var inserted: Bool = false
    
    var completeDialogue: Bool = true
    
    var action: (() -> Void)
    
    var type: TypeTrasmisson
    
    var oldStates: [CommandState]

    //MARK: Variável para construção

    lazy var circleWithImage: SKShapeNode = {
        let circle = SKShapeNode(circleOfRadius: UIScreen.main.bounds.size.width * 0.035)
        
        circle.fillColor = .black
        circle.strokeColor = .clear
        circle.alpha = 1
        circle.zPosition = ZPositions.message
        circle.fillTexture = image

        return circle
    }()

    lazy var bodyMessage: SKLabelNode = {
        let bodyMessage = SKLabelNode(text: message)
        bodyMessage.verticalAlignmentMode = .center
        bodyMessage.horizontalAlignmentMode = .right
        bodyMessage.fontSize = UIScreen.main.bounds.size.height * 0.030
        bodyMessage.fontName = FontsCustom.font1
        bodyMessage.zPosition = ZPositions.message
        
        return bodyMessage
    }()

    
    /// Here will be constructor to initialize the message to be constructed.
    /// - Parameters:
    ///   - type: The Person who will talk (TypeTrasmisson).
    ///   - message: The String that will be read by the transmission.
    ///   - typeCommand: If it is any contain some command will be executed(up, down, left, right and pilot).
    ///   - oldStates: Here you will get all the old states of the commands.
    ///   - action: Function to execute if the whole message is read.
    public init(_ type :TypeTrasmisson, message: String, typeCommand: CommandType, oldStates: [CommandState], action: @escaping (() -> Void)) {
        
        self.oldStates = oldStates
        
        self.typeCommand = typeCommand
        
        self.type = type
        
        self.message = message
        
        self.action = action
        
        switch type {
        case .reciver:
            self.legendSong = SKAudioNode(fileNamed: "Som_legenda_2.mp3")
        case .sender:
            self.legendSong = SKAudioNode(fileNamed: "Som_legenda_1.mp3")
        }
        
        
        super.init(texture: nil,color: .clear, size: CGSize(width: 0, height: 0))
        
        switch type {
        case .sender:
            image = SKTexture(imageNamed: "Icon/TowerIcon")
            self.circleWithImage.fillTexture = image
            self.circleWithImage.position.x = UIScreen.main.bounds.size.width * 0.45
            self.bodyMessage.horizontalAlignmentMode = .right
            self.bodyMessage.position.x = circleWithImage.position.x - (circleWithImage.frame.size.width * 0.65)
            self.legendSong.run(.changeVolume(by: 20, duration: 0))
        case .reciver:
            image = SKTexture(imageNamed: "Icon/PilotIcon")
            self.circleWithImage.fillTexture = image
            self.circleWithImage.position.x = -(UIScreen.main.bounds.size.width * 0.45)
            self.bodyMessage.horizontalAlignmentMode = .left
            self.bodyMessage.position.x = circleWithImage.position.x + (circleWithImage.frame.size.width * 0.65)
            self.legendSong.run(.changeVolume(by: 20, duration: 0))
        }
        self.circleWithImage.addChild(SKSpriteNode(texture: image, color: .clear, size: self.circleWithImage.frame.size))
        self.addChild(circleWithImage)
        self.addChild(bodyMessage)
        
        self.addChild(self.legendSong)
        
        self.legendSong.autoplayLooped = true
        self.bodyMessage.text = ""
        
    }
    
    /// Animation letter-by-letter..
    public func animateText() {

        self.bodyMessage.text?.append(message.removeFirst())

    }
    
    func update(dt: TimeInterval) {
        
        timer += 1
        if (timer%6 == 0) && !(message.isEmpty) {
            animateText()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
