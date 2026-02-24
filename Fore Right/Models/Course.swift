import Foundation
import SwiftData

@Model
final class Course {
    var name: String
    @Relationship(deleteRule: .cascade)
    var holes: [Hole]
    var sortedHoles: [Hole] {
        holes.sorted { $0.number < $1.number }
    }
    var length: Int {
        holes.count
    }
    @Relationship(deleteRule: .cascade)
    var rounds: [Round]?
    var par: Int { holes.reduce(0) { $0 + $1.par } }

    static let icon: String = "house.and.flag"

    init(name: String = "", holes: [Hole] = []) {
        self.name = name
        self.holes = holes.isEmpty ? Course.generateHoles() : holes
    }

    static func generateHoles() -> [Hole] {
        (1...18).map { holeNumber in
            Hole(
                number: holeNumber,
                par: 4
            )
        }
    }
}
