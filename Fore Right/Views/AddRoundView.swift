import SwiftData
import SwiftUI

struct AddRoundView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var path: NavigationPath

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
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return AddRoundView(path: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
