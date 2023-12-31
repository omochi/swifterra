public struct Block: Decl {
    public init(
        name: Keyword,
        arguments: [String],
        items: [any Decl]
    ) {
        self.name = name
        self.arguments = arguments
        self.items = items
    }

    public var name: Keyword
    public var arguments: [String]
    public var items: [any Decl]

    public init(
        _ name: String,
        _ arguments: String...,
        @DeclsBuilder items: () -> [any Decl]
    ) {
        self.init(
            name: Keyword(name),
            arguments: arguments,
            items: items()
        )
    }
}
