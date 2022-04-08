//
//  Randomness.swift
//  
//
//  Created by Felipe Souza Marra on 08/04/22.
//

import GameplayKit

protocol Randomness {
    
    var randomness: GKRandomDistribution { get }
    
    func returnIntRandom() -> Int
    
}

extension Randomness {
    
    func returnIntRandom() -> Int {
        return self.randomness.nextInt()
    }
    
}
