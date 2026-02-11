import Foundation
import SwiftData

@Model
final class Round {
    var date: Date
    var course: Course
    var numStrokesPerHole: [UInt8]

    init(date: Date) {
        self.date = date
        self.course = .init(name: "Test Course", holes: [])
        self.numStrokesPerHole = []
    }
}
