// Created by Julian Dunskus

import UIKit

let defaults = UserDefaults.standard

private extension String {
	static let scoreKey = "score"
	static let highscoreKey = "highscore"
	static let mainColorKey = "mainColor"
	static let wrongColorKey = "wrongColor"
	static let wrongIndexKey = "wrongIndex"
	static let hasLostKey = "hasLost"
}

extension UserDefaults {
	var score: Int {
		get { return integer(forKey: .scoreKey) }
		set { set(newValue, forKey: .scoreKey) }
	}
	
	var highscore: Int {
		get { return integer(forKey: .highscoreKey) }
		set { set(newValue, forKey: .highscoreKey) }
	}
	
	var mainColor: UIColor? {
		get {
			guard let raw = data(forKey: .mainColorKey) else { return nil }
			return try! NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: raw)
		}
		set {
			let raw = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
			set(raw, forKey: .mainColorKey)
		}
	}
	
	var wrongColor: UIColor? {
		get {
			guard let raw = data(forKey: .wrongColorKey) else { return nil }
			return try! NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: raw)
		}
		set {
			let raw = try! NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
			set(raw, forKey: .wrongColorKey)
		}
	}
	
	var hasLost: Bool {
		get { return bool(forKey: .hasLostKey) }
		set { set(newValue, forKey: .hasLostKey) }
	}
}
