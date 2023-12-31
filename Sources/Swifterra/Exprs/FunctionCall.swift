public struct FunctionCall: Expr {
    public init(
        name: Symbol,
        arguments: [any Expr]
    ) {
        self.name = name
        self.arguments = arguments
    }
    
    public var name: Symbol
    public var arguments: [any Expr]

    public init(
        _ name: String,
        _ arguments: (any Expr)...
    ) {
        self.init(
            name: Symbol(name),
            arguments: arguments
        )
    }
}
