import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Rounds", systemImage: Round.icon) {
                NavigationStack {
                    ListRoundsView()
                }
            }

            Tab("Courses", systemImage: Course.icon) {
                NavigationStack {
                    ListCoursesView()
                }
            }
        }
    }
}

#Preview {
    let previewer = Previewer(
        Round.self,
        Course.self,
        Hole.self
    )
    let courses = Course.sampleCourses
    previewer.addExamples(courses)
    previewer.addExamples(Round.sampleRounds(using: courses))

    return ContentView()
        .modelContainer(previewer.container)
}
