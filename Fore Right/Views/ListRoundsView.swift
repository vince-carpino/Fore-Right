import SwiftData
import SwiftUI

struct ListRoundsView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: [
        SortDescriptor(\Round.date, order: .reverse)
    ]) var rounds: [Round]

    var body: some View {
        List {
            ForEach(rounds) { round in
                NavigationLink(value: round) {
                    VStack(alignment: .leading) {
                        if let courseName = round.course?.name {
                            Text(courseName)
                        }

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
                NoListItemsView(
                    title: "No rounds yet",
                    icon: "figure.golf",
                    description: "You haven't logged any rounds yet.",
                    buttonText: "Add a Round",
                    buttonIcon: "plus.circle.fill",
                    buttonAction: addRound,
                )
            }
        }
        .toolbar {
            if !rounds.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addRound) {
                        Label("Add Round", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle("Rounds")
        .navigationDestination(for: Round.self) { round in
            if round.course == nil && round.numStrokesPerHole.isEmpty {
                AddRoundView(path: $path)
            } else {
                Text("Edit Round View")
            }
        }
    }

    func addRound() {
        let newRound = Round()
        path.append(newRound)
    }
}

#Preview {
    let previewer = Previewer(Round.self)
    previewer.addExamples(Round.sampleRounds)

    return NavigationStack {
        ListRoundsView()
            .modelContainer(previewer.container)
    }
}
