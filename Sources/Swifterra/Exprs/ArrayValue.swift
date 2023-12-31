public struct ArrayValue: Expr {
    public init(
        items: [any Expr]
    ) {
        self.items = items
    }

    public var items: [any Expr]

    public init(
        _ items: (any Expr)...
    ) {
        self.items = items
    }

    public init(
        @ExprsBuilder items: () -> [any Expr]
    ) {
        self.init(
            items: items()
        )
    }
}
