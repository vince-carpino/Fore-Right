import Foundation
import SwiftData

@Model
final class Round {
    var date: Date
    var course: Course?
    var numStrokesPerHole: [Int]

    init(date: Date = .now, course: Course? = nil) {
        self.date = date
        self.course = course
        self.numStrokesPerHole = []
    }
}
