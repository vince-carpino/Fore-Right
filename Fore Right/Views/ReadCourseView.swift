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
                        Text("Front")
                            .textCase(.uppercase)
                        Spacer()
                        Text("Par \(frontPar)")
                            .textCase(.uppercase)
                    }
                }

                Section {
                    ForEach(backHoles) { hole in
                        HoleView(hole: hole)
                    }
                } header: {
                    HStack {
                        Text("Back")
                            .textCase(.uppercase)
                        Spacer()
                        Text("Par \(backPar)")
                            .textCase(.uppercase)
                    }
                }
            } else {
                Section {
                    ForEach(course.sortedHoles) { hole in
                        HoleView(hole: hole)
                    }
                } header: {
                    HStack {
                        Text("Holes")
                            .textCase(.uppercase)
                        Spacer()
                        Text("Par \(course.par)")
                            .textCase(.uppercase)
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
