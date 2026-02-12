import SwiftUI

struct NewRoundView: View {
    @State private var date: Date = Date()
    @State private var showingSheet: Bool = false

    var body: some View {
        Text("New Round")
            .font(.largeTitle)
            .bold()
            .padding()

        Text("Course")
            .padding()
        Button {
            print("add new course")
            showingSheet = true
        } label: {
            Text("Add New Course")
                .padding()
        }.sheet(isPresented: $showingSheet) {
            NewCourseView()
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
}

#Preview {
    NewRoundView()
}
