import SwiftData
import SwiftUI

struct CourseHoleRow: View {
    var hole: Hole

    var body: some View {
        HStack {
            HoleLabel(hole: hole)
            Spacer()
            ParLabel(hole: hole)
        }
        .font(.title3)
        .lineLimit(1)
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
        CourseHoleRow(hole: courses[0].holes[0])
            .modelContainer(previewer.container)
    }
}
