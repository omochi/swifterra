public struct StringValue: Expr & ExpressibleByStringLiteral & ExpressibleByStringInterpolation {
    public enum Item {
        case string(String)
        case expr(any Expr)
    }

    public init(
        items: [Item]
    ) {
        self.items = items
    }

    public var items: [Item]

    public init(stringLiteral value: String) {
        self.init(items: [.string(value)])
    }

    public init(stringInterpolation: StringInterpolation) {
        self.init(items: stringInterpolation.items)
    }

    public struct StringInterpolation: StringInterpolationProtocol {
        public typealias StringLiteralType = String

        public init(literalCapacity: Int, interpolationCount: Int) {
            self.items = []
        }

        public var items: [Item] = []

        public mutating func appendLiteral(_ literal: String) {
            items.append(.string(literal))
        }

        public mutating func appendInterpolation(_ value: some Expr) {
            items.append(.expr(value))
        }
    }
}
