public struct ObjectValue: Expr {
    public init(
        items: [Attribute]
    ) {
        self.items = items
    }

    public var items: [Attribute]

    public init(
        @AttributesBuilder items: () -> [Attribute]
    ) {
        self.init(
            items: items()
        )
    }
}
