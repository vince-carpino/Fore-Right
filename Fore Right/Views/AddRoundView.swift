import SwiftData
import SwiftUI

struct AddRoundView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Course.name) var courses: [Course]

    @State private var selectedCourseID: PersistentIdentifier?
    var selectedCourse: Course? {
        guard let selectedCourseID else { return nil }
        return courses.first(where: { $0.id == selectedCourseID })
    }
    @State private var strokesPerHole: [Int] = []
    @State private var datePlayed: Date = .now

    private var totalStrokes: Int { strokesPerHole.reduce(0, +) }
    private var isReady: Bool { selectedCourse != nil && !strokesPerHole.isEmpty }

    var body: some View {
        Form {
            Section {
                if courses.isEmpty {
                    Text("No saved courses")
                        .foregroundStyle(Color.gray)
                } else {
                    Picker("Course", selection: $selectedCourseID) {
                        if selectedCourse == nil {
                            Text("Select a course")
                                .tag(nil as PersistentIdentifier?)
                        }
                        ForEach(courses) { course in
                            Text(course.name)
                                .tag(Optional(course.id))
                        }
                    }
                    .onChange(of: selectedCourse) { _, newValue in
                        guard let newValue else {
                            strokesPerHole = []
                            return
                        }
                        strokesPerHole = newValue.sortedHoles.map { $0.par }
                    }
                }

                NavigationLink {
                    AddCourseView()
                } label: {
                    Label("Add Course", systemImage: "plus.circle.fill")
                        .foregroundStyle(Color.accent)
                }
            } header: {
                HStack {
                    Text("Round".uppercased())
                    Spacer()
                    if isReady {
                        Text("\(totalStrokes) Strokes".uppercased())
                    }
                }
            }

            Section {
                DatePicker(
                    "Date Played",
                    selection: $datePlayed,
                    displayedComponents: [.date]
                )
            }

            if let selectedCourse,
               strokesPerHole.count == selectedCourse.holes.count
            {
                if selectedCourse.holes.count == 18 {
                    let frontHoles = Array(selectedCourse.sortedHoles.prefix(9))
                    let backHoles = Array(selectedCourse.sortedHoles.dropFirst(9))

                    Section {
                        ForEach(frontHoles.indices, id: \.self) { index in
                            HoleInputRow(hole: frontHoles[index], strokes: $strokesPerHole[index])
                        }
                    } header: {
                        HStack {
                            Text("Front".uppercased())
                            Spacer()
                            Text("Par \(frontHoles.reduce(0) { $0 + $1.par })".uppercased())
                        }
                    }

                    Section {
                        ForEach(backHoles.indices, id: \.self) { index in
                            HoleInputRow(hole: backHoles[index], strokes: $strokesPerHole[index + 9])
                        }
                    } header: {
                        HStack {
                            Text("Back".uppercased())
                            Spacer()
                            Text("Par \(backHoles.reduce(0) { $0 + $1.par })".uppercased())
                        }
                    }
                } else {
                    Section {
                        ForEach(selectedCourse.sortedHoles.indices, id: \.self) { index in
                            HoleInputRow(hole: selectedCourse.sortedHoles[index], strokes: $strokesPerHole[index])
                        }
                    } header: {
                        HStack {
                            Text("Holes".uppercased())
                            Spacer()
                            Text("Par \(selectedCourse.par)".uppercased())
                        }
                    }
                }

                Button(action: saveRound) {
                    Label("Save Round", systemImage: "flame.fill")
                }
                .foregroundStyle(isReady ? .accent : .gray)
                .disabled(!isReady)
            }
        }
        .navigationTitle("New Round")
        .navigationBarTitleDisplayMode(.inline)
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
