import Foundation

infix operator <-: NilCoalescingPrecedence

@discardableResult public func <- <T>(value: T, transform: (inout T) throws -> Void) rethrows -> T {
	var copy = value
	try transform(&copy)
	return copy
}

infix operator ???: NilCoalescingPrecedence

func ??? <Wrapped>(optional: Wrapped?, error: @autoclosure () -> Error) throws -> Wrapped {
	guard let unwrapped = optional else { throw error() }
	return unwrapped
}

extension Sequence {
	func count(where condition: (Element) throws -> Bool) rethrows -> Int {
		return try lazy.filter(condition).count
	}
}

prefix operator ^

prefix func ^ <S, T> (keyPath: KeyPath<S, T>) -> (S) -> T {
	return { $0[keyPath: keyPath] }
}

extension Comparable {
	func clamped(to range: ClosedRange<Self>) -> Self {
		return min(range.upperBound, max(range.lowerBound, self))
	}
}
