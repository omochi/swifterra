import Foundation

enum Files {
    static func write(data: Data, to file: URL) throws {
        let fm = FileManager.default

        let dir = file.deletingLastPathComponent()
        if !fm.fileExists(atPath: dir.path) {
            try fm.createDirectory(at: dir, withIntermediateDirectories: true)
        }

        try data.write(to: file, options: .atomic)
    }

    static func writeIfChange(data: Data, to file: URL) throws {
        let fm = FileManager.default

        if fm.fileExists(atPath: file.path) {
            let old = try Data(contentsOf: file)
            if data == old { return }
        }

        try write(data: data, to: file)
    }
}
