import SwiftUI

struct ContentView: View {
    @State private var navManager: NavigationManager = .shared

    var body: some View {
        NavigationStack(path: $navManager.path) {
            VStack {
                Spacer()

                Text("Fore Right!")
                    .font(.largeTitle)
                    .bold()
                    .italic()
                    .padding()

                Spacer()

                PrimaryButton(label: "New Round") {
                    navManager.path.append(NavigationPage.newRound)
                }
                .padding()
            }
            .navigationDestination(for: NavigationPage.self) { page in
                switch page {
                case .newRound:
                    NewRoundView()
                default:
                    Text("Something went wrong...")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
