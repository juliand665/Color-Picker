import Foundation

extension Comparable {
	func clamped(to range: ClosedRange<Self>) -> Self {
		min(range.upperBound, max(range.lowerBound, self))
	}
}
