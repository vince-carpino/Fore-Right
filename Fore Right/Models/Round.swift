import Foundation
import SwiftData

@Model
final class Round {
    var date: Date
    var course: Course?
    var numStrokesPerHole: [Int]

    static let icon: String = "figure.golf"

    init(
        date: Date = .now,
        course: Course? = nil,
        numStrokesPerHole: [Int] = []
    ) {
        self.date = date
        self.course = course
        self.numStrokesPerHole = numStrokesPerHole
    }
}
