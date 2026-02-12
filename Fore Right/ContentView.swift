import SwiftUI

struct ContentView: View {
    @State private var showingSheet: Bool = false

    var body: some View {
        Spacer()

        Text("Fore Right!")
            .font(.largeTitle)
            .bold()
            .italic()
            .padding()

        Spacer()

        PrimaryButton(label: "New Round") {
            showingSheet = true
            print("new round")
        }.sheet(isPresented: $showingSheet) {
            NewRoundView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
