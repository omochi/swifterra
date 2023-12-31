@resultBuilder
public struct DeclsBuilder {
    public static func buildBlock(_ components: (any Decl)...) -> [any Decl] {
        components
    }
}
