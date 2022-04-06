//
//  File.swift
//  
//
//  Created by Felipe Souza Marra on 05/04/22.
//

import Foundation
import SwiftUI
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = SKView()
        
        guard let myView = view as? SKView else {return}
        
        print(myView.ignoresSiblingOrder)
        
        myView.ignoresSiblingOrder = false
        myView.isMultipleTouchEnabled = true
        myView.showsFPS = true
        myView.showsNodeCount = false
        myView.showsPhysics = true
        
        dump(UIScreen.main.bounds.size)
        
        let scene = GameScene(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        scene.scaleMode = .aspectFill
        
        myView.presentScene(scene)
        
    }
}
