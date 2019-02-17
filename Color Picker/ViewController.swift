// Created by Julian Dunskus

import SpriteKit

class ViewController: UIViewController {
	@IBOutlet var sceneView: SKView!
	
	@IBOutlet var scoreLabel: UILabel!
	@IBOutlet var highscoreLabel: UILabel!
	
	let scene = Scene()
	
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
