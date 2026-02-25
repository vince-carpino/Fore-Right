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
                NavigationLink {
                    VStack {
                        Text("Read Round View")
                            .font(.headline)

                        if let courseName = round.course?.name {
                            Text(courseName)
                            Text(
                                "on \(round.date.formatted(date: .long, time: .omitted))"
                            )
                        }
                    }
                } label: {
                    VStack(alignment: .leading) {
                        if let courseName = round.course?.name {
                            Text(courseName)
                                .font(.headline)
                        }

                        HStack {
                            Text(round.scoreRelativeToParFormatted)
                            Text("•")
                            Text("\(round.totalStrokes)")
                            Divider()
                            Text(
                                round.date.formatted(
                                    date: .abbreviated,
                                    time: .omitted
                                )
                            )
                            .textCase(.uppercase)
                        }
                        .font(.caption)
                        .bold()
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
                    icon: Round.icon,
                    description: "You haven't logged any rounds yet.",
                    buttonText: "Add a Round",
                    buttonIcon: "plus.circle.fill",
                    destination: AddRoundView()
                )
            }
        }
        .toolbar {
            if !rounds.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddRoundView()
                    } label: {
                        Label("New Round", systemImage: "plus")
                    }
                }
            }
        }
        .navigationTitle(rounds.isEmpty ? "" : "Rounds")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    let previewer = Previewer(
        Round.self,
        Course.self,
        Hole.self
    )
    let courses = Course.sampleCourses
    previewer.addExamples(courses)
    previewer.addExamples(Round.sampleRounds(using: courses))

    return NavigationStack {
        ListRoundsView()
            .modelContainer(previewer.container)
    }
}
