@resultBuilder
public struct ExprsBuilder {
    public static func buildBlock(_ components: (any Expr)...) -> [any Expr] {
        components
    }
}
