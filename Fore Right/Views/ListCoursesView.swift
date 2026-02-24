import SwiftData
import SwiftUI

struct ListCoursesView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Course.name) var courses: [Course]

    var body: some View {
        List {
            ForEach(courses) { course in
                NavigationLink(course.name) {
                    VStack {
                        Text("Edit Course View")
                        Text(course.name)
                        ForEach(course.holes) { hole in
                            HStack {
                                Text("Hole \(hole.number)")
                                Divider()
                                Text("Par \(hole.par)")
                            }
                        }
                    }
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    modelContext.delete(courses[index])
                }
            }

        }
        .overlay {
            if courses.isEmpty {
                NoListItemsView(
                    title: "No saved courses",
                    icon: "tree.fill",
                    description: "You haven't saved any courses yet.",
                    buttonText: "Add a Course",
                    buttonIcon: "plus.circle.fill",
                    buttonAction: addCourse,
                )
            }
        }
        .toolbar {
            if !courses.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addCourse) {
                        Label("Add Course", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle("Courses")
        .navigationDestination(for: Course.self) { course in
            if course.name == "" && course.holes.isEmpty {
                AddCourseView(path: $path)
            } else {
                Text("Edit Course View")
            }
        }
    }

    func addCourse() {
        let newCourse = Course()
        path.append(newCourse)
    }
}

#Preview {
    let previewer = Previewer(Course.self)
    previewer.addExamples(Course.sampleCourses)

    return NavigationStack {
        ListCoursesView()
            .modelContainer(previewer.container)
    }
}
