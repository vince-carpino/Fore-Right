import SwiftUI

struct ContentView: View {
    @State private var path: [NavigationPage] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Spacer()

                Text("Fore Right!")
                    .font(.largeTitle)
                    .bold()
                    .italic()
                    .padding()

                Spacer()

                PrimaryButton(label: "New Round") {
                    path.append(.addRound)
                }
                .padding()
            }
            .navigationDestination(for: NavigationPage.self) { page in
                switch page {
                case .addRound:
                    AddRoundView(path: $path)
                case .addCourse:
                    AddCourseView(path: $path)
                case .editCourse:
                    if let course = NavigationManager.shared.tempCourse {
                        EditCourseView(course: course)
                    } else {
                        Text("No course to edit")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
