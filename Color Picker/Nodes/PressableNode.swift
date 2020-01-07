import SpriteKit

class PressableNode: SKNode {
	var isPressed = false
	
	override init() {
		super.init()
		
		isUserInteractionEnabled = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		isPressed = true
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touch = touches.first!
		isPressed = contains(touch.location(in: parent!))
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if isPressed {
			nodePressed()
		}
		
		isPressed = false
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		isPressed = false
	}
	
	func nodePressed() {}
}
