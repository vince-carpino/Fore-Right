import SwiftUI

struct NewCourseView: View {
    @State private var path = NavigationPath()
    @State private var courseName: String = ""
    @State private var numHoles: Int = 18

    var numHolesOptions: [Int] = [9, 18]

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("New Course")
                    .font(.largeTitle)
                    .bold()
                    .padding()

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
                    path.append(newCourse)
                } label: {
                    Text("Next")
                        .padding()
                        .border(.gray)
                }
                .disabled(courseName.isEmpty)
            }
            .navigationDestination(for: Course.self) { course in
                EditCourseView(course: course)
            }
        }
    }
}

#Preview {
    NewCourseView()
}
