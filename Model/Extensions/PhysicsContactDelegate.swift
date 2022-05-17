import SpriteKit

//MARK: PhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let node1 = contact.bodyA.node?.name == "Pilot" ? contact.bodyA.node : contact.bodyB.node
        
        if node1?.name == "Pilot" {
            self.isPaused = true
            self.view?.presentScene(GameFinished(size: CGSize(width: self.width, height: self.height), type: .lost), transition: .fade(withDuration: 3))
        }
        
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        print("Saindo do contato")
    }
    
}
