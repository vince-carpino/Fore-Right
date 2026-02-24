import SwiftData
import SwiftUI

struct AddCourseView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var courseName: String = ""
    @State private var holes: [Hole] = []
    @State private var numHoles: Int = 18

    var numHolesOptions: [Int] = [9, 18]
    var parRange = 3...7

    private func generateHoles() {
        holes = (1...numHoles).map { number in
            Hole(number: number, par: 4)
        }
    }

    var body: some View {
        VStack {
            Form {
                Section("Course - Par \(holes.reduce(0) { $0 + $1.par })".uppercased()) {
                    TextField("Course Name", text: $courseName)
                        .textInputAutocapitalization(.words)

                    HStack {
                        Picker("Holes", selection: $numHoles) {
                            ForEach(numHolesOptions, id: \.self) {
                                Text("\($0) holes")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }

                Section("Front - Par \(holes.prefix(9).reduce(0) { $0 + $1.par })".uppercased()) {
                    ForEach($holes[..<min(9, holes.count)]) { $hole in
                        HStack {
                            Text("Hole \(hole.number)")
                            Divider()
                            Stepper("Par \(hole.par)", value: $hole.par, in: parRange)
                                .sensoryFeedback(.increase, trigger: hole.par)
                        }
                    }
                }

                if numHoles > 9 {
                    Section("Back - Par \(holes.dropFirst(9).reduce(0) { $0 + $1.par })".uppercased()) {
                        ForEach($holes.dropFirst(9)) { $hole in
                            HStack {
                                Text("Hole \(hole.number)")
                                Divider()
                                Stepper("Par \(hole.par)", value: $hole.par, in: parRange)
                                    .sensoryFeedback(.increase, trigger: hole.par)
                            }
                        }
                    }
                }

                Button(action: saveCourse) {
                    Label("Save", systemImage: "checkmark.circle.fill")
                }
                .foregroundStyle(courseNameIsEmpty() ? .gray : .accent)
                .disabled(courseNameIsEmpty())
            }
        }
        .onAppear {
            generateHoles()
        }
        .onChange(of: numHoles) {
            generateHoles()
        }
        .navigationTitle("New Course")
        .navigationBarTitleDisplayMode(.inline)
    }

    func courseNameIsEmpty() -> Bool {
        return courseName.isEmpty
    }

    func saveCourse() {
        let course = Course(name: courseName, holes: holes)
        modelContext.insert(course)
        path.removeLast()
    }
}

#Preview {
    let previewer = Previewer()

    return NavigationStack {
        AddCourseView()
            .modelContainer(previewer.container)
    }
}
