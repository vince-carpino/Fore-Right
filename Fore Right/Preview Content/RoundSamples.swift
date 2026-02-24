import Foundation

extension Round {
    static func sampleRounds(using courses: [Course]) -> [Round] {
        (1...5).map { _ in
            Round(
                date: Calendar.current.date(
                    byAdding: .day,
                    value: Int.random(in: -30 ... -7),
                    to: .now
                )!,
                course: courses.randomElement()!
            )
        }
    }
}
