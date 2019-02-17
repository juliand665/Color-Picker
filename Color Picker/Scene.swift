// Created by Julian Dunskus

import SpriteKit

final class Scene: SKScene {
	var squares: [ColorButton] = []
	
	var center: CGPoint {
		return size.asPoint / 2
	}
	
	override init() {
		super.init(size: CGSize(width: 1024, height: 1024))
		
		squares.append(ColorButton(at: center) <-* addChild)
		
		backgroundColor = .clear
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
