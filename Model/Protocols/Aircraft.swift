import SpriteKit

//MARK: Aircraft

protocol Aircraft: AnyObject, AutoLayout {
    
    func defineType(type: TypeAircraft) -> (texture: SKTexture, size: CGSize)
    
    func addPhysics(texture: SKTexture, size: CGSize) -> SKPhysicsBody
    
    func defineVelocity(type: TypeAircraft) -> CGFloat
    
}

extension Aircraft {
    
    public func defineType(type: TypeAircraft) -> (texture: SKTexture, size: CGSize) {
        
        let texture: SKTexture
        var size: CGSize
        
        switch type {
        case .pilot:
            texture = SKTexture(imageNamed: "Aeronave/Aeronave1")
            size = texture.size()
        case .airplane:
            texture = SKTexture(imageNamed: "Aeronave/Aeronave2")
            size = texture.size()
        case .freighter:
            texture = SKTexture(imageNamed: "Aeronave/Aeronave3")
            size = texture.size()
        }
        
        size.height = size.height * (height / 2200)
        size.width = size.width * (height / 2200)
        
        return (texture, size)
        
    }
    
    public func addPhysics(texture: SKTexture, size: CGSize) -> SKPhysicsBody {
        let body = SKPhysicsBody(texture: texture, size: size)
        
        body.isDynamic = false
        body.categoryBitMask = CategoryMaskPhysics.smallAircraft
        body.contactTestBitMask = CategoryMaskPhysics.smallAircraft + CategoryMaskPhysics.mediumAircraft + CategoryMaskPhysics.bigAircraft
        body.collisionBitMask = 0
        body.isDynamic = false
        
        return body
    }
    
    public func defineVelocity(type: TypeAircraft) -> CGFloat {
        
        let velocity: CGFloat
        
        switch type {
        case .pilot:
            velocity =  6 * (height / 1366)
        case .airplane:
            velocity =  4 * (height / 1366)
        case .freighter:
            velocity =  3 * (height / 1366)
        }
        
        return velocity
        
    }
    
}
