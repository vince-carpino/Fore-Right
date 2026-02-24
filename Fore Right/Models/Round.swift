import Foundation
import SwiftData

@Model
final class Round {
    var date: Date
    var course: Course?
    var numStrokesPerHole: [Int]

    var totalStrokes: Int { numStrokesPerHole.reduce(0, +) }
    var scoreRelativeToPar: Int {
        guard let par = course?.par else { return 0 }
        return totalStrokes - par
    }
    var scoreRelativeToParFormatted: String {
        let score = scoreRelativeToPar
        switch score {
        case 0: return "E"
        case 1...: return "+\(score)"
        default: return "\(score)"
        }
    }

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
