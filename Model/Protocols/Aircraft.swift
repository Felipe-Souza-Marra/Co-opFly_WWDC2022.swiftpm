import SpriteKit

//MARK: Aircraft

protocol Aircraft: AnyObject {
    
    func defineType(type: TypeAircraft) -> (texture: SKTexture, size: CGSize)
    
    func addPhysics(texture: SKTexture, size: CGSize) -> SKPhysicsBody
    
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
        
        dump(size)
        
        size.height = size.height / 3
        size.width = size.width / 3
        
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
    
}
