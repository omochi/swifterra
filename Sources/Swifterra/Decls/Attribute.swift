public typealias A = Attribute

public struct Attribute: Decl {
    public init(
        name: String,
        value: some Expr
    ) {
        self.name = name
        self.value = value
    }

    public var name: String
    public var value: any Expr

    public init(
        _ name: String,
        _ value: some Expr
    ) {
        self.init(
            name: name,
            value: value
        )
    }
}
