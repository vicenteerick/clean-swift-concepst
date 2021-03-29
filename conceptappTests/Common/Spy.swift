import Foundation

@propertyWrapper
public struct Spy<Value> {
    public private(set) var value: Value
    public private(set) var history: [Value] = []

    var count: Int {
        return history.count
    }

    public init(wrappedValue: Value) {
        value = wrappedValue
    }

    public var wrappedValue: Value {
        get { value }
        set {
            history.append(newValue)
            value = newValue
        }
    }

    public var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
}
