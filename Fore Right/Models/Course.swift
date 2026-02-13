import Foundation
import SwiftData

@Model
final class Course {
    var name: String
    var holes: [Hole]

    init(name: String = "", holes: [Hole] = []) {
        self.name = name
        self.holes = holes
    }
}
