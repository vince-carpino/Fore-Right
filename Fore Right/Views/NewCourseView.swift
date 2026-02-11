import SwiftUI

struct NewCourseView: View {
    @State private var courseName: String = ""
    @State private var par: UInt8 = 0
    @State private var numHoles: UInt8 = 18

    var numHolesOptions: [UInt8] = [18, 9]

    var body: some View {
        Text("New Course")
            .font(.largeTitle)
            .bold()
            .padding()

        Text("Name")
        TextField("Course Name", text: $courseName)
            .padding()

        Text("Par")
        TextField("Par", value: $par, format: .number)
            .padding()

        Text("Holes")
        Picker("Holes", selection: $numHoles) {
            ForEach(numHolesOptions, id: \.self) {
                Text("\($0)")
            }
        }
        .pickerStyle(.segmented)
        .padding()

        Button {
            print("save course:")
            print("name: \(courseName)")
            print("par: \(par)")
            print("holes: \(numHoles)")
        } label: {
            Text("Save")
        }
        .disabled(courseName.isEmpty || par == 0)

    }
}

#Preview {
    NewCourseView()
}
