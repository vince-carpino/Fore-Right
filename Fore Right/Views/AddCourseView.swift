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
        VStack {
            Form {
                Section {
                    TextField("Course Name", text: $courseName)
                        .textInputAutocapitalization(.words)

                    HStack {
                        Picker("Holes", selection: $numHoles) {
                            ForEach(numHolesOptions, id: \.self) {
                                Text("\($0) holes".uppercased())
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    HStack {
                        Text("Course".uppercased())
                        Spacer()
                        Text("Par \(par)".uppercased())
                    }
                }

                if numHoles == 18 {
                    let frontCount = min(9, holes.count)
                    let backStart = min(9, holes.count)

                    let frontHoles = holes.prefix(frontCount)
                    let backHoles = holes.dropFirst(backStart)

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
                            Text("Front".uppercased())
                            Spacer()
                            Text(
                                "Par \(frontHoles.reduce(0) { $0 + $1.par })"
                                    .uppercased()
                            )
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
                            Text("Back".uppercased())
                            Spacer()
                            Text(
                                "Par \(backHoles.reduce(0) { $0 + $1.par })"
                                    .uppercased()
                            )
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
                            Text("Holes".uppercased())
                            Spacer()
                            Text(
                                "Par \(allHoles.reduce(0) { $0 + $1.par })"
                                    .uppercased()
                            )
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
