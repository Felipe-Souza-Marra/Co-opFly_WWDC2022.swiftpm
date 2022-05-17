//
//  CloudAbove.swift
//  
//
//  Created by Felipe Souza Marra on 10/04/22.
//

import SpriteKit
import GameplayKit

class CloudAbove: SKSpriteNode, Cloud, Randomness {
    
    var randomness: GKRandomDistribution
    
    var randomInt: GKRandomDistribution
    
    var scaleRandom: GKRandomDistribution
    
    /// Automated builder for the clouds to come randomly.
    init() {
        self.randomInt = GKRandomDistribution(lowestValue: 0, highestValue: 180)
        self.randomness = GKRandomDistribution(lowestValue: 1, highestValue: 100)
        self.scaleRandom = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        super.init(texture: nil, color: .clear,size: CGSize(width: 0, height: 0))
        self.zPosition = ZPositions.nuvem
        self.name = "Cloud"
        
        var texture: SKTexture, size: CGSize, scale: Int
        
        switch randomness.nextInt() {
        case 1...33:
            texture = SKTexture(imageNamed: "Cenario/Nuvem1")
        case 34...67:
            texture = SKTexture(imageNamed: "Cenario/Nuvem2")
        default:
            texture = SKTexture(imageNamed: "Cenario/Nuvem3")
        }
        
        self.texture = texture
        
        let widthMultiplier = width / 1024
        
        size = texture.size()
        
        scale = scaleRandom.nextInt()
        
        size.width = size.width * CGFloat(scale) * widthMultiplier
        size.height = size.height * CGFloat(scale) * widthMultiplier
        
        self.size = size
        
        self.zRotation = self.rotation()
        
        self.position.x = self.width * (CGFloat(self.randomness.nextUniform()) - 0.5)
        
    }
    
    /// Function for cloud removal.
    func offScreen() {
        
        guard let camera = scene?.camera else { return }
        
        if camera.position.y > (self.position.y + ((self.width * 0.8) + self.size.height/2)) {
            
            self.removeFromParent()
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
