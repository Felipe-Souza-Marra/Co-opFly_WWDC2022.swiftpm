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
    
    var message: String
    
    var inserted: Bool = false
    
    var completeDialogue: Bool = true
    
    var action: (() -> Void)
    
    var type: TypeTrasmisson

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
        bodyMessage.zPosition = ZPositions.message
        
        return bodyMessage
    }()


    public init(_ type :TypeTrasmisson, message: String, action: @escaping (() -> Void)) {
        
        self.type = type
        
        self.message = message
        
        self.action = action
        
        super.init(texture: nil,color: .clear, size: CGSize(width: 0, height: 0))
        
        switch type {
        case .sender:
            image = SKTexture(imageNamed: "Algo")
            self.circleWithImage.position.x = UIScreen.main.bounds.size.width * 0.45
            self.bodyMessage.horizontalAlignmentMode = .right
            self.bodyMessage.position.x = circleWithImage.position.x - (circleWithImage.frame.size.width * 0.65)
            
        case .reciver:
            image = SKTexture(imageNamed: "Algo")
            self.circleWithImage.position.x = -(UIScreen.main.bounds.size.width * 0.45)
            self.bodyMessage.horizontalAlignmentMode = .left
            self.bodyMessage.position.x = circleWithImage.position.x + (circleWithImage.frame.size.width * 0.65)
        }
        
        self.addChild(circleWithImage)
        self.addChild(bodyMessage)
        
    
        self.bodyMessage.text = ""
        
    }
    
    public func animateText() {

        self.bodyMessage.text?.append(message.removeFirst())

    }
    
    func update(dt: TimeInterval) {
        
        timer += 1
        if (timer%10 == 0) && !(message.isEmpty) {
          animateText()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
