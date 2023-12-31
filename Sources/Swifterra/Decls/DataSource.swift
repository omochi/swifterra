public struct DataSource: Decl {
    public init(
        type: String,
        name: String,
        items: [any Decl]
    ) {
        self.type = type
        self.name = name
        self.items = items
    }

    public var type: String
    public var name: String
    public var items: [any Decl]

    public init(
        _ type: String,
        _ name: String,
        @DeclsBuilder items: () -> [any Decl]
    ) {
        self.init(
            type: type,
            name: name,
            items: items()
        )
    }
}
