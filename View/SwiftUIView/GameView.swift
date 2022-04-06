import SwiftUI

struct GameView: View {
    var body: some View {
        GeometryReader{ space in
            ControllerRepresentable()
                .frame(width: space.size.width, height: space.size.height, alignment: .center)
        }
        .ignoresSafeArea()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct ControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = GameViewController
    
    func makeUIViewController(context: Context) -> GameViewController {
        return GameViewController()
    }
    
    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {}
    
}
