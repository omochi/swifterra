public struct Symbol: Expr & RawRepresentable {
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }

    public init(rawValue: String) {
        self.init(rawValue)
    }

    public var rawValue: String
}
