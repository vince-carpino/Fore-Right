import SwiftData
import SwiftUI

struct HoleView: View {
    @Bindable var hole: Hole

    var body: some View {
        HStack {
            Text("Hole".uppercased())
            Image(systemName: hole.icon)

            Spacer()

            Text("Par".uppercased())
            Image(systemName: hole.parIcon)
        }
        .font(.title3)
        .lineLimit(1)
        .minimumScaleFactor(0.01)
        .bold()
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

    return NavigationStack {
        HoleView(hole: courses[0].holes[0])
            .modelContainer(previewer.container)
    }
}
