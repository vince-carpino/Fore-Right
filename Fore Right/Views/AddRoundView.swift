import SwiftData
import SwiftUI

struct AddRoundView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query var courses: [Course]
    @State private var selectedCourse: Course?

    @State private var date: Date = .now

    var body: some View {
        Form {
            Section {
                if courses.isEmpty {
                    Text("No saved courses")
                        .foregroundStyle(Color.gray)
                } else {
                    Picker("Course", selection: $selectedCourse) {
                        if selectedCourse == nil {
                            Text("Select a course")
                                .tag(nil as Course?)
                        }

                        ForEach(courses) { course in
                            Text(course.name)
                                .tag(Optional(course))
                        }
                    }
                }

                Button() {
                    let newCourse = Course()
                    path.append(newCourse)
                } label: {
                    Label("Add Course", systemImage: "plus.circle")
                }
            }

            Section {
                DatePicker(
                    "Date Played",
                    selection: $date,
                    displayedComponents: [.date]
                )
            }
        }
        .navigationTitle("Add Round")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Course.self) { course in
            if course.name == "" && course.holes.isEmpty {
                AddCourseView(path: $path)
            }
        }

    func saveRound() {
        let round = Round(date: datePlayed, course: selectedCourse, numStrokesPerHole: strokesPerHole)
        modelContext.insert(round)
        dismiss()
    }
}

#Preview {
    let previewer = Previewer(Round.self, Course.self, Hole.self)
    previewer.addExamples(Course.sampleCourses)

    return NavigationStack {
        AddRoundView()
            .modelContainer(previewer.container)
    }
}
