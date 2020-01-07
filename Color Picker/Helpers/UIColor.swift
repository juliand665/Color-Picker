import UIKit
import HandyOperators

// oh god the API
extension UIColor {
	var red: CGFloat {
		.nan <- { getRed(&$0, green: nil, blue: nil, alpha: nil) }
	}
	
	func withRed(_ red: CGFloat) -> UIColor {
		UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	
	var green: CGFloat {
		.nan <- { getRed(nil, green: &$0, blue: nil, alpha: nil) }
	}
	
	func withGreen(_ green: CGFloat) -> UIColor {
		UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	
	var blue: CGFloat {
		.nan <- { getRed(nil, green: nil, blue: &$0, alpha: nil) }
	}
	
	func withBlue(_ blue: CGFloat) -> UIColor {
		UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	
	var alpha: CGFloat {
		.nan <- { getRed(nil, green: nil, blue: nil, alpha: &$0) }
	}
	
	func withAlpha(_ alpha: CGFloat) -> UIColor {
		UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
	
	
	var hue: CGFloat {
		.nan <- { getHue(&$0, saturation: nil, brightness: nil, alpha: nil) }
	}
	
	func withHue(_ hue: CGFloat) -> UIColor {
		UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
	
	
	var saturation: CGFloat {
		.nan <- { getHue(nil, saturation: &$0, brightness: nil, alpha: nil) }
	}
	
	func withSaturation(_ saturation: CGFloat) -> UIColor {
		UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
	
	
	var brightness: CGFloat {
		.nan <- { getHue(nil, saturation: nil, brightness: &$0, alpha: nil) }
	}
	
	func withBrightness(_ brightness: CGFloat) -> UIColor {
		UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
}
