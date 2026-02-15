import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let round: Round
    let course: Course

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Round.self, configurations: config)

        course = Course(name: "Oso Creek", holes: [])
        round = Round(date: .now, course: course)

//        container.mainContext.insert(round)
    }
}
