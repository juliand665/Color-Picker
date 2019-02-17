// Created by Julian Dunskus

import SpriteKit

final class ColorButton: PressableNode {
	static let size = CGSize(width: 192, height: 192)
	
	let square = SKShapeNode(rect: CGRect(origin: -size.asPoint / 2, size: size), cornerRadius: 32) <- {
		$0.lineWidth = 16
	}
	
	var color: SKColor = .clear {
		didSet {
			square.fillColor = color
			square.strokeColor = color.withBrightness(color.brightness - 0.2)
		}
	}
	
	override var isPressed: Bool {
		didSet {
			if isPressed != oldValue {
				run(.scale(to: isPressed ? 0.85 : 1, duration: 0.05))
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
}
