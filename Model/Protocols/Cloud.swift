//
//  File.swift
//  
//
//  Created by Felipe Souza Marra on 10/04/22.
//

import GameplayKit

protocol Cloud {
    
    var randomInt: GKRandomDistribution { get }
    
    var scaleRandom: GKRandomDistribution { get }
    
    func rotation() -> CGFloat
    
}

extension Cloud {
    
    /// Returns a rotation for the cloud.
    func rotation() -> CGFloat {
        
        let number: CGFloat = CGFloat(self.randomInt.nextInt())
        
        let rotation = ((number - 90)/360 * 2 * Double.pi)
        
        return rotation
        
    }
    
}
