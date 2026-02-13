import SwiftUI

struct AddRoundView: View {
    @Binding var path: [NavigationPage]

    @State private var date: Date = Date()

    var body: some View {
        VStack {
            Text("Course")
                .padding()
            Button {
                path.append(.addCourse)
            } label: {
                Text("Add New Course")
                    .padding()
            }
            .border(.gray)

            DatePicker(
                "Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .padding()

            Button {
                print("next")
            } label: {
                Text("Next")
                    .padding()
            }
            .border(.gray)
        }
        .navigationTitle("New Round")
    }
}

#Preview {
    AddRoundView(path: .constant([]))
}
