import SwiftUI

struct NewRoundView: View {
    @State private var date: Date = Date()
    @State private var showNewCourseModel: Bool = false

    var body: some View {
        Text("New Round")
            .font(.largeTitle)
            .bold()

        Text("Course")
            .padding()
        Button {
            print("add new course")
            showNewCourseModel = true
        } label: {
            Text("Add New Course")
                .padding()
        }.sheet(isPresented: $showNewCourseModel) {
            NewCourseView()
        }

        Text("Date")
            .padding()
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
        }
    }
}

#Preview {
    NewRoundView()
}
