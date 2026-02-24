import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var roundsPath = NavigationPath()
    @State private var coursesPath = NavigationPath()

    var body: some View {
        TabView {
            Tab("Rounds", systemImage: Round.icon) {
                NavigationStack(path: $roundsPath) {
                    ListRoundsView(path: $roundsPath)
                }
            }

            Tab("Courses", systemImage: Course.icon) {
                NavigationStack(path: $coursesPath) {
                    ListCoursesView(path: $coursesPath)
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
