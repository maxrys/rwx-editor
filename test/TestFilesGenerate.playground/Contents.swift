
import Foundation

let FILE_COUNT = 500

if let home = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    for i in 1 ... FILE_COUNT {
        let file = home.appendingPathComponent("file_\(i).txt")
        do {
            let line = "file \(i) content"
            try line.write(to: file, atomically: true, encoding: .utf8)
            print("Saved OK: \(file.path)")
        } catch {
            print("Saved FAILED: \(file.path)")
        }
    }
    print("Created \(FILE_COUNT) files in: \(home.path)")
}
