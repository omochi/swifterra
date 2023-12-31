public struct TFFile {
    public init(
        name: String,
        items: [any Decl]
    ) {
        self.name = name
        self.items = items
    }

    public var name: String
    public var items: [any Decl]

    public init(
        _ name: String,
        @DeclsBuilder items: () -> [any Decl]
    ) {
        self.init(
            name: name,
            items: items()
        )
    }

    public func render() throws -> String {
        let r = Renderer()
        return try r.render(file: self)
    }
}
