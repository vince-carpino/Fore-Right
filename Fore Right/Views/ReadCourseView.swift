import SwiftData
import SwiftUI

struct ReadCourseView: View {
    var course: Course

    private var frontHoles: [Hole] { Array(course.sortedHoles.prefix(9)) }
    private var backHoles: [Hole] { Array(course.sortedHoles.dropFirst(9)) }

    private var frontPar: Int { frontHoles.reduce(0) { $0 + $1.par } }
    private var backPar: Int { backHoles.reduce(0) { $0 + $1.par } }

    private var pageTitle: String {
        course.length == 18 ? "\(course.name) — Par \(course.par)" : course.name
    }

    var body: some View {
        Form {
            if course.length == 18 {
                Section {
                    ForEach(frontHoles) { hole in
                        HoleView(hole: hole)
                    }
                } header: {
                    HStack {
                        Text("Front".uppercased())
                        Spacer()
                        Text(
                            "Par \(frontPar)"
                                .uppercased()
                        )
                    }
                }

                Section {
                    ForEach(backHoles) { hole in
                        HoleView(hole: hole)
                    }
                } header: {
                    HStack {
                        Text("Back".uppercased())
                        Spacer()
                        Text(
                            "Par \(backPar)"
                                .uppercased()
                        )
                    }
                }
            } else {
                Section {
                    ForEach(course.sortedHoles) { hole in
                        HoleView(hole: hole)
                    }
                } header: {
                    HStack {
                        Spacer()
                        Text("Par \(course.par)".uppercased())
                    }
                }
            }
        }
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let previewer = Previewer(Round.self, Course.self, Hole.self)
    let courses = Course.sampleCourses
    previewer.addExamples(courses)

    return NavigationStack {
        ReadCourseView(course: courses[0])
            .modelContainer(previewer.container)
    }
}
