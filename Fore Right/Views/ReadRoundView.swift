import SwiftData
import SwiftUI

struct ReadRoundView: View {
    var round: Round

    var body: some View {
        VStack {
            Text("Read Round View")
                .font(.headline)

            if let courseName = round.course?.name {
                Text(courseName)
                Text(
                    "on \(round.date.formatted(date: .long, time: .omitted))"
                )
            }
        }
    }
}

#Preview {
    let previewer = Previewer(Round.self, Course.self, Hole.self)
    let courses = Course.sampleCourses
    let rounds = Round.sampleRounds(using: courses)
    previewer.addExamples(courses)

    return NavigationStack {
        ReadRoundView(round: rounds[0])
            .modelContainer(previewer.container)
    }
}
