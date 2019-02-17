// Created by Julian Dunskus

import SpriteKit

class ViewController: UIViewController {
	@IBOutlet var sceneView: SKView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sceneView.presentScene(Scene())
	}
}
