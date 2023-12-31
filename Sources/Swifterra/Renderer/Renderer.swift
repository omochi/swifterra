final class Renderer {
    public init() {
    }

    public func render(
        file: TFFile
    ) throws -> String {
        let printer = PrettyPrinter()
        printer.indent = "  "
        let impl = Impl(printer: printer)
        try impl.render(file: file)
        return impl.p.output
    }
}

private final class Impl {
    init(
        printer: PrettyPrinter
    ) {
        self.p = printer
    }

    let p: PrettyPrinter

    func render(decl: any Decl) throws {
        switch decl {
        case let d as Attribute:
            try render(attribute: d)
        case let d as Block:
            try render(block: d)
        case let d as DataSource:
            try render(dataSource: d)
        case let d as Resource:
            try render(resource: d)
        default:
            throw MessageError("unknown decl: \(type(of: decl))")
        }
    }

    func render(expr: any Expr) throws {
        switch expr {
        case let e as Int:
            render(int: e)
        case let e as Double:
            render(double: e)
        case let e as String:
            render(string: e)
        case let e as Symbol:
            render(symbol: e)
        case let e as ArrayValue:
            try render(array: e)
        case let e as ObjectValue:
            try render(object: e)
        case let e as FunctionCall:
            try render(functionCall: e)
        default:
            throw MessageError("unknown expr: \(type(of: expr))")
        }
    }

    func render(
        file: TFFile
    ) throws {
        for (index, item) in file.items.enumerated() {
            if index > 0 {
                p.writeNewline()
            }

            try render(decl: item)
            p.writeNewline()
        }
    }

    func render(attribute: Attribute) throws {
        p.write(attribute.name)
        p.write(" = ")
        try render(expr: attribute.value)
    }

    func render(block: Block) throws {
        try renderBlock(
            name: block.name,
            arguments: block.arguments,
            items: block.items
        )
    }

    func render(dataSource: DataSource) throws {
        try renderBlock(
            name: Keyword("data"),
            arguments: [dataSource.type, dataSource.name],
            items: dataSource.items
        )
    }

    func render(resource: Resource) throws {
        try renderBlock(
            name: Keyword("resource"),
            arguments: [resource.type, resource.name],
            items: resource.items
        )
    }

    private func renderBlock(
        name: Keyword,
        arguments: [String],
        items: [any Decl]
    ) throws {
        render(keyword: name)
        for argument in arguments {
            p.write(space: " ")
            render(string: argument)
        }
        p.write(space: " ", "{")
        try p.nest {
            for item in items {
                try render(decl: item)
                p.writeNewline()
            }
        }
        p.write("}")
    }

    func render(int: Int) {
        p.write(int.description)
    }

    func render(double: Double) {
        p.write(double.description)
    }

    func render(string: String) {
        let q = "\""
        p.write(q + string + q)
    }

    func render(keyword: Keyword) {
        p.write(keyword.rawValue)
    }

    func render(symbol: Symbol) {
        p.write(symbol.rawValue)
    }

    func render(array: ArrayValue) throws {
        p.write("[")
        try p.nest {
            for (index, item) in array.items.enumerated() {
                try render(expr: item)
                if index < array.items.count - 1 {
                    p.write(",")
                }
                p.writeNewline()
            }
        }
        p.write("]")
    }

    func render(object: ObjectValue) throws {
        p.write("{")
        try p.nest {
            for item in object.items {
                try render(attribute: item)
                p.writeNewline()
            }
        }
        p.write("}")

    }
    func render(functionCall: FunctionCall) throws{
        render(symbol: functionCall.name)
        p.write("(")
        try p.nest {
            for (index, item) in functionCall.arguments.enumerated() {
                try render(expr: item)
                if index < functionCall.arguments.count - 1 {
                    p.write(",")
                }
                p.writeNewline()
            }
        }
        p.write(")")
    }
}
