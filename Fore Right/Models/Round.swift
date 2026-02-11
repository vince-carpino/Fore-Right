import Foundation
import SwiftData

@Model
final class Round {
    var date: Date
    var course: Course
    var numStrokesPerHole: [UInt8]

    init(date: Date, course: Course) {
        self.date = date
        self.course = course
        self.numStrokesPerHole = []
    }
}
