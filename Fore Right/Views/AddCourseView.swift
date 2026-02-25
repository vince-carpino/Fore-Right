import SwiftData
import SwiftUI

struct AddCourseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var courseName: String = ""
    @State private var holes: [Hole] = []
    @State private var numHoles: Int = 18

    private var numHolesOptions: [Int] = [9, 18]
    private var parRange = 3...7
    private var par: Int {
        holes.reduce(0) { $0 + $1.par }
    }

    private func generateHoles() {
        holes = (1...numHoles).map { number in
            Hole(number: number, par: 4)
        }
    }

    var body: some View {
        Form {
            Section {
                TextField("Course Name", text: $courseName)
                    .textInputAutocapitalization(.words)

                HStack {
                    Picker("Holes", selection: $numHoles) {
                        ForEach(numHolesOptions, id: \.self) {
                            Text("\($0) holes")
                                .textCase(.uppercase)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            } header: {
                HStack {
                    Text("Course")
                        .textCase(.uppercase)
                    Spacer()
                    Text("Par \(par)")
                        .textCase(.uppercase)
                }
            }

            if numHoles == 18 {
                let splitIndex = min(9, holes.count)
                let frontHoles = holes.prefix(splitIndex)
                let backHoles = holes.dropFirst(splitIndex)

                Section {
                    ForEach(frontHoles.indices, id: \.self) { index in
                        HStack {
                            HoleView(hole: holes[index])
                            Stepper(
                                "",
                                value: $holes[index].par,
                                in: parRange
                            )
                            .sensoryFeedback(
                                .increase,
                                trigger: holes[index].par
                            )
                        }
                    }
                } header: {
                    HStack {
                        Text("Front")
                            .textCase(.uppercase)
                        Spacer()
                        Text("Par \(frontHoles.reduce(0) { $0 + $1.par })")
                            .textCase(.uppercase)
                    }
                }

                Section {
                    ForEach(backHoles.indices, id: \.self) { index in
                        HStack {
                            HoleView(hole: holes[index])
                            Stepper(
                                "",
                                value: $holes[index].par,
                                in: parRange
                            )
                            .sensoryFeedback(
                                .increase,
                                trigger: holes[index].par
                            )
                        }
                    }
                } header: {
                    HStack {
                        Text("Back")
                            .textCase(.uppercase)
                        Spacer()
                        Text("Par \(backHoles.reduce(0) { $0 + $1.par })")
                            .textCase(.uppercase)
                    }
                }
            } else {
                let holesCount = min(9, holes.count)
                let allHoles = holes.prefix(holesCount)

                Section {
                    ForEach(allHoles.indices, id: \.self) { index in
                        HStack {
                            HoleView(hole: holes[index])
                            Stepper(
                                "",
                                value: $holes[index].par,
                                in: parRange
                            )
                            .sensoryFeedback(
                                .increase,
                                trigger: holes[index].par
                            )
                        }
                    }
                } header: {
                    HStack {
                        Text("Holes")
                            .textCase(.uppercase)
                        Spacer()
                        Text("Par \(allHoles.reduce(0) { $0 + $1.par })")
                            .textCase(.uppercase)
                    }
                }
            }

            Button(action: saveCourse) {
                Label("Save", systemImage: "checkmark.circle.fill")
            }
            .foregroundStyle(courseNameIsEmpty() ? .gray : .accent)
            .disabled(courseNameIsEmpty())
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
        dismiss()
    }
}

#Preview {
    let previewer = Previewer(
        Round.self,
        Course.self,
        Hole.self
    )

    return NavigationStack {
        AddCourseView()
            .modelContainer(previewer.container)
    }
}
