import SwiftData
import SwiftUI

@main
struct Fore_RightApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Round.self,
        ])
    }
}
