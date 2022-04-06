import SpriteKit

//MARK: PhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        print("Entrando em contato")
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        print("Saindo do contato")
    }
    
}
