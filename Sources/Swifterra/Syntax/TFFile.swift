import Foundation

public struct TFFile {
    public init(
        items: [any Decl]
    ) {
        self.items = items
    }

    public var items: [any Decl]

    public init(
        @DeclsBuilder items: () -> [any Decl]
    ) {
        self.init(
            items: items()
        )
    }

    public func render() throws -> String {
        let r = Renderer()
        return try r.render(file: self)
    }
}
