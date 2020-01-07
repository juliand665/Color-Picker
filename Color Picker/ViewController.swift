import SpriteKit

final class ViewController: UIViewController {
	@IBOutlet private var sceneView: SKView!
	
	@IBOutlet private var scoreLabel: UILabel!
	@IBOutlet private var highscoreLabel: UILabel!
	
	private let scene = Scene()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scene.sceneDelegate = self
		sceneView.presentScene(scene)
	}
}

extension ViewController: SceneDelegate {
	func scoreChanged(to score: Int) {
		scoreLabel.text = "\(scene.score)"
	}
	
	func highscoreChanged(to score: Int) {
		highscoreLabel.text = "\(scene.highscore)"
	}
}
