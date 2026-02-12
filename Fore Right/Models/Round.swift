import Foundation
import SwiftData

@Model
final class Round {
    var course: Course
    var date: Date
    var numStrokesPerHole: [Int]

    init(course: Course, date: Date, numStrokesPerHole: [Int] = []) {
        self.course = course
        self.date = date
        self.numStrokesPerHole = numStrokesPerHole
    }
}
