import SwiftUI

struct AddCourseView: View {
    @Binding var path: [NavigationPage]

    @State private var courseName: String = ""
    @State private var numHoles: Int = 18

    var numHolesOptions: [Int] = [9, 18]

    var body: some View {
        VStack {
            TextField("Course Name", text: $courseName)
                .textInputAutocapitalization(.words)
                .padding()
                .border(.gray)
                .padding()

            HStack {
                HStack {
                    Text("Holes")
                    Spacer()
                }
                Picker("Holes", selection: $numHoles) {
                    ForEach(numHolesOptions, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()

            Button {
                let newHoles = (1...numHoles).map {
                    Hole(number: $0, par: 4)
                }
                let newCourse = Course(name: courseName, holes: newHoles)
                NavigationManager.shared.tempCourse = newCourse
                path.append(.editCourse)
            } label: {
                Text("Next")
                    .padding()
                    .border(.gray)
            }
            .disabled(courseName.isEmpty)
        }
        .navigationTitle("New Course")
    }
}

#Preview {
    AddCourseView(path: .constant([]))
}
