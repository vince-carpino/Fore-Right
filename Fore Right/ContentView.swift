import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = NavigationPath()

    @Query(sort: [
        SortDescriptor(\Round.date, order: .reverse)
    ]) var rounds: [Round]

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(rounds) { round in
                    NavigationLink(value: round) {
                        VStack(alignment: .leading) {
                            Text(round.course?.name ?? "No course")

                            Text(
                                round.date.formatted(
                                    date: .long,
                                    time: .omitted
                                )
                            )
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(rounds[index])
                    }
                }
            }
            .overlay {
                if rounds.isEmpty {
                    ContentUnavailableView {
                        Label("No rounds yet", systemImage: "figure.golf")
                    } description: {
                        Text("You haven't logged any rounds yet.")
                    } actions: {
                        Button(action: addRound) {
                            Label("Add a Round", systemImage: "plus.circle")
                                .bold()
                                .padding(5)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Rounds")
            .navigationDestination(for: Round.self) { round in
                if round.course == nil && round.numStrokesPerHole.isEmpty {
                    AddRoundView(path: $path)
                } else {
                    EditRoundView(round: round, path: $path)
                }
            }
            .toolbar {
                if !rounds.isEmpty {
                    Button(
                        "Add Round",
                        systemImage: "plus.circle",
                        action: addRound
                    )
                }
            }
        }
    }

    func addRound() {
        let newRound = Round()
        path.append(newRound)
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return ContentView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
