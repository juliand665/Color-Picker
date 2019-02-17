import Foundation

infix operator <-*: NilCoalescingPrecedence
infix operator <-: NilCoalescingPrecedence

@discardableResult public func <- <T>(value: T, transform: (inout T) throws -> Void) rethrows -> T {
	var copy = value
	try transform(&copy)
	return copy
}

@discardableResult public func <-* <T>(value: T, handle: (T) throws -> Void) rethrows -> T {
	try handle(value)
	return value
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
