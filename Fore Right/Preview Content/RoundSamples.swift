import Foundation

extension Round {
    static func sampleRounds(using courses: [Course]) -> [Round] {
        let course: Course = courses.randomElement()!

        return (1...5).map { _ in
            Round(
                date: Calendar.current.date(
                    byAdding: .day,
                    value: Int.random(in: -30 ... -7),
                    to: .now
                )!,
                course: course,
                numStrokesPerHole: (1...course.length).map { _ in Int.random(in: 3...7) }
            )
        }
    }
}
