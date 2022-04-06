
//MARK: AutoLayout

import SpriteKit

protocol AutoLayout {
    
    var height: CGFloat { get }
    var width: CGFloat { get }
    
}

extension AutoLayout {
    
    var height: CGFloat {
        
        get {
            return UIScreen.main.bounds.size.height
        }
        
    }
    
    var width: CGFloat {
        
        get {
            return UIScreen.main.bounds.size.width
        }
        
    }
    
}
