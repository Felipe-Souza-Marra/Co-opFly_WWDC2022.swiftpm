import SpriteKit

//MARK: PhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let node1 = contact.bodyA.node?.name == "Pilot" ? contact.bodyA.node : contact.bodyB.node
        let node2 = node1 == contact.bodyA.node ? contact.bodyB.node : contact.bodyA.node
        
        print("Contato")
        
        if node1?.name == "Pilot" {
            node1?.run(.fadeOut(withDuration: 0.5))
            if let pilot = node1 as? Pilot {
                pilot.physicsBody = nil
            }
            node2?.run(.fadeOut(withDuration: 0.5))
            node1?.run(.wait(forDuration: 2)){
                self.commands?.down.setCanBeTight(false)
                self.commands?.left.setCanBeTight(false)
                self.commands?.right.setCanBeTight(false)
                self.run(.wait(forDuration: 2)) {
                    self.view?.presentScene(GameFinished(size: CGSize(width: self.width, height: self.height)), transition: .fade(withDuration: 2))
                }
            }
        }
        
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        print("Saindo do contato")
    }
    
}
