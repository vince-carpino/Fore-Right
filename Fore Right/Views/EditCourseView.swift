import SwiftUI
import SwiftData

struct EditCourseView: View {
    @Bindable var course: Course

    private let parOptionsRange = 3...7

    var body: some View {
        VStack {
            Text("Par: \(course.holes.reduce(0) { $0 + $1.par })")

            TabView {
                Tab("Front", systemImage: "9.circle") {
                    VStack {
                        ForEach($course.holes[..<9]) { $hole in
                            HStack {
                                Text("Hole \(hole.number)")
                                Stepper(value: $hole.par, in: parOptionsRange) {
                                    Text("Par: \(hole.par)")
                                }
                                .sensoryFeedback(.increase, trigger: hole.par)
                            }
                            .padding()
                        }
                    }
                }

                Tab("Back", systemImage: "18.circle") {
                    VStack {
                        ForEach($course.holes[9...]) { $hole in
                            HStack {
                                Text("Hole \(hole.number)")
                                Stepper(value: $hole.par, in: parOptionsRange) {
                                    Text("Par \(hole.par)")
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationTitle(course.name)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Course.self, Hole.self,
        configurations: config
    )

    let holes = (1...18).map {
        Hole(number: $0, par: Int.random(in: 3...5))
    }

    let course = Course(name: "Oso Creek", holes: holes)
    container.mainContext.insert(course)

    return EditCourseView(course: course)
        .modelContainer(container)
}
