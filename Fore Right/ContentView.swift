import SwiftUI
//import SwiftData

struct ContentView: View {
    var body: some View {
        Spacer()

        Text("Fore Right!")
            .font(.title)
            .bold()
            .italic()

        Spacer()

        PrimaryButton(label: "New Round") {
            print("new round")
        }
    }
}

#Preview {
    ContentView()
}
