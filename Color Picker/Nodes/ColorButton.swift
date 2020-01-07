import SpriteKit
import HandyOperators
import CGeometry

final class ColorButton: PressableNode {
	static let size = CGSize(width: 208, height: 208)
	
	weak var delegate: ColorButtonDelegate?
	
	private let square = SKShapeNode(rect: CGRect(origin: -CGPoint(size / 2), size: size), cornerRadius: 48) <- {
		$0.lineWidth = 12
	}
	
	var color: SKColor = .clear {
		didSet {
			square.fillColor = color
			square.strokeColor = color.withBrightness((color.brightness - 0.1).clamped(to: 0...1))
		}
	}
	
	override var isPressed: Bool {
		didSet {
			if isPressed != oldValue {
				run(.scale(to: isPressed ? 0.85 : 1, duration: 0.05))
				
				if isPressed {
					delegate?.colorButtonPressStarted()
				} else {
					delegate?.colorButtonPressCancelled()
				}
			}
		}
	}
	
	init(at position: CGPoint) {
		super.init()
		
		self.position = position
		addChild(square)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func nodePressed() {
		delegate?.colorButtonPressed(self)
	}
}

protocol ColorButtonDelegate: AnyObject {
	func colorButtonPressStarted()
	func colorButtonPressCancelled()
	func colorButtonPressed(_ colorButton: ColorButton)
}

extension ColorButtonDelegate {
	func colorButtonPressStarted() {}
	func colorButtonPressCancelled() {}
}
