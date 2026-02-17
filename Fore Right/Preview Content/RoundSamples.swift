import Foundation

extension Round {
    static var sampleRounds: [Round] {
        (1...5).map { _ in
            Round(
                date: Calendar.current.date(
                    byAdding: .day,
                    value: Int.random(in: -30 ... -7),
                    to: Date.now
                )!,
                course: Course.sampleCourses.randomElement()!
            )
        }
    }
}
