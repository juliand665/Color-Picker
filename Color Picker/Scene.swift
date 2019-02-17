// Created by Julian Dunskus

import SpriteKit

final class Scene: SKScene {
	weak var sceneDelegate: SceneDelegate? {
		didSet {
			sceneDelegate?.scoreChanged(to: score)
			sceneDelegate?.highscoreChanged(to: highscore)
		}
	}
	
	var colorButtons: [ColorButton] = []
	
	var center: CGPoint {
		return size.asPoint / 2
	}
	
	var score = defaults.score {
		didSet {
			defaults.score = score
			sceneDelegate?.scoreChanged(to: score)
		}
	}
	
	var highscore = defaults.highscore {
		didSet {
			defaults.highscore = highscore
			sceneDelegate?.highscoreChanged(to: highscore)
		}
	}
	
	var hasLost = defaults.hasLost {
		didSet {
			defaults.hasLost = hasLost
		}
	}
	
	var mainColor: UIColor!
	var wrongColor: UIColor!
	
	override init() {
		super.init(size: CGSize(width: 1024, height: 1024))
		
		let offsets = stride(from: -1.5, through: 1.5, by: 1)
		colorButtons = offsets.flatMap { y in
			offsets.map { x in
				ColorButton(at: center + CGPoint(x: x, y: y) * 0.25 * size)
			}
		}
		colorButtons.forEach {
			addChild($0)
			$0.delegate = self
		}
		
		backgroundColor = .clear
		
		if let mainColor = defaults.mainColor, let wrongColor = defaults.wrongColor {
			self.mainColor = mainColor
			self.wrongColor = wrongColor
			updateColors()
		} else {
			randomizeColors()
		}
		
		if hasLost {
			lose()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func randomizeColors() {
		let minDistance: CGFloat = 1/256
		
		mainColor = UIColor(
			hue: .random(in: 0...1),
			saturation: .random(in: 0.5...1),
			brightness: .random(in: 0.5...0.9),
			alpha: 1
		)
		
		let offset = (minDistance + 1 / CGFloat(score + 1))
		func randomize(_ component: CGFloat) -> CGFloat {
			let signedOffset = Bool.random() ? offset : -offset
			return (component + signedOffset).clamped(to: 0...1)
		}
		wrongColor = UIColor(
			red: randomize(mainColor.red),
			green: randomize(mainColor.green),
			blue: randomize(mainColor.blue),
			alpha: 1
		)
		
		defaults.mainColor = mainColor
		defaults.wrongColor = wrongColor
		
		updateColors()
	}
	
	func updateColors() {
		colorButtons.forEach { $0.color = mainColor }
		
		colorButtons.randomElement()!.color = wrongColor
	}
	
	func lose() {
		Haptics.notify.notificationOccurred(.error)
		
		hasLost = true
		colorButtons.forEach { button in
			let isOddOneOut = button.color == wrongColor
			button.run(.scale(to: isOddOneOut ? 1.1 : 0.9, duration: 0.1))
		}
	}
	
	func restart() {
		Haptics.notify.notificationOccurred(.warning)
		
		score = 0
		hasLost = false
		
		let delay = 0.15
		let rotate = SKAction.rotate(byAngle: -.pi, duration: delay)
		let hide = SKAction.run { [colorButtons] in
			colorButtons.forEach {
				$0.run(.group([rotate, .scale(to: 0, duration: delay)]))
			}
		}
		let show = SKAction.run { [colorButtons] in
			colorButtons.forEach {
				$0.run(.group([rotate, .scale(to: 1, duration: delay)]))
			}
		}
		
		let actions = [
			hide,
			.wait(forDuration: delay),
			.run(randomizeColors),
			show
		]
		run(.sequence(actions))
	}
	
	func advance() {
		Haptics.mediumImpact.impactOccurred()
		
		score += 1
		if score > highscore {
			highscore = score
		}
		randomizeColors()
	}
}

extension Scene: ColorButtonDelegate {
	func colorButtonPressed(_ colorButton: ColorButton) {
		guard !hasLost else {
			restart()
			return
		}
		if colorButton.color == mainColor {
			lose()
		} else {
			advance()
		}
	}
}

protocol SceneDelegate: AnyObject {
	func scoreChanged(to score: Int)
	func highscoreChanged(to score: Int)
}
