import SwiftData
import SwiftUI

struct ListCoursesView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Course.name) var courses: [Course]

    var body: some View {
        List {
            ForEach(courses) { course in
                NavigationLink {
                    ReadCourseView(course: course)
                } label: {
                    VStack(alignment: .leading) {
                        Text(course.name)
                            .bold()

                        HStack {
                            Text("\(course.holes.count) Holes")
                                .textCase(.uppercase)
                            Divider()
                            Text("Par \(course.par)")
                                .textCase(.uppercase)
                        }
                        .bold()
                        .font(.caption)
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
                    icon: "\(Course.icon).fill",
                    description: "You haven't saved any courses yet.",
                    buttonText: "Add a Course",
                    buttonIcon: "plus.circle.fill",
                    destination: AddCourseView()
                )
            }
        }
        .toolbar {
            if !courses.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddCourseView()
                    } label: {
                        Label("Add Course", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle(courses.isEmpty ? "" : "Courses")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    let previewer = Previewer(
        Round.self,
        Course.self,
        Hole.self
    )
    previewer.addExamples(Course.sampleCourses)

    return NavigationStack {
        ListCoursesView()
            .modelContainer(previewer.container)
    }
}
