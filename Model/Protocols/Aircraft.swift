import SpriteKit

//MARK: Aircraft

protocol Aircraft: AnyObject, AutoLayout {
    
    func defineType(type: TypeAircraft) -> (texture: SKTexture, size: CGSize)
    
    func addPhysics(texture: SKTexture, size: CGSize) -> SKPhysicsBody
    
    func defineVelocity(type: TypeAircraft) -> CGFloat
    
}

extension Aircraft {
    
    /// Setting the plane type to return the texture and size.
    /// - Parameter type: The aircraft type.
    /// - Returns: Texture and size.
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
        
        let widthMultiplier = width / 1858
        
        size.height = size.height * widthMultiplier
        size.width = size.width * widthMultiplier
        
        return (texture, size)
        
    }
    
    public func addPhysics(texture: SKTexture, size: CGSize) -> SKPhysicsBody {
        let body = SKPhysicsBody(texture: texture, size: size)
        
        body.categoryBitMask = CategoryMaskPhysics.smallAircraft
        body.contactTestBitMask = CategoryMaskPhysics.smallAircraft + CategoryMaskPhysics.mediumAircraft + CategoryMaskPhysics.bigAircraft
        body.collisionBitMask = 0
        body.affectedByGravity = false
        
        return body
    }
    
    public func defineVelocity(type: TypeAircraft) -> CGFloat {
        
        let velocity: CGFloat
        
        switch type {
        case .pilot:
            velocity =  Velocity.pilot * (height / 1366)
        case .airplane:
            velocity =  Velocity.airplane * (height / 1366)
        case .freighter:
            velocity =  Velocity.freighter * (height / 1366)
        }
        
        return velocity
        
    }
    
}
