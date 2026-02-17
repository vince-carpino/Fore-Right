import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = NavigationPath()

    @Query(sort: [
        SortDescriptor(\Round.date, order: .reverse)
    ]) var rounds: [Round]

    var body: some View {
        NavigationStack(path: $path) {
            ListRoundsView(path: $path)
//            ListCoursesView(path: $path)
        }
    }
}

#Preview {
    let previewer = Previewer(Round.self)
//    previewer.addExamples(Round.sampleRounds)
//    previewer.addExamples(Course.sampleCourses)

    return NavigationStack {
        ContentView()
            .modelContainer(previewer.container)
    }
}
