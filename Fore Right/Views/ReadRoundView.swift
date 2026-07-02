import SwiftData
import SwiftUI

struct ReadRoundView: View {
    var round: Round

    private var course: Course? { round.course }
    private var strokesPerHole: [Int] { round.numStrokesPerHole }
    private var totalStrokes: Int { strokesPerHole.reduce(0, +) }
    private var totalPar: Int { course?.par ?? 0 }
    private var relativeToPar: Int { totalStrokes - totalPar }
    private var relativeLabel: String {
        switch relativeToPar {
        case 0: return "E"
        case 1...: return "+\(relativeToPar)"
        default: return "\(relativeToPar)"
        }
    }
    private var relativeColor: Color {
        switch relativeToPar {
        case ..<0: return .green
        case 0: return .primary
        default: return .red
        }
    }

    var body: some View {
        Form {
            Section {
                LabeledContent("Course", value: course?.name ?? "Unknown")
                LabeledContent("Date Played", value: round.date.formatted(date: .abbreviated, time: .omitted))
            } header: {
                HStack {
                    Text("Round")
                        .textCase(.uppercase)
                    Spacer()
                    Text("\(totalStrokes) Strokes (\(relativeLabel))")
                        .textCase(.uppercase)
                        .foregroundStyle(relativeColor)
                }
            }

            if let course, strokesPerHole.count == course.holes.count {
                if course.holes.count == 18 {
                    let frontHoles = Array(course.sortedHoles.prefix(9))
                    let backHoles = Array(course.sortedHoles.dropFirst(9))
                    let frontStrokes = Array(strokesPerHole.prefix(9))
                    let backStrokes = Array(strokesPerHole.dropFirst(9))

                    Section {
                        ForEach(frontHoles.indices, id: \.self) { index in
                            RoundHoleRow(
                                hole: frontHoles[index],
                                strokes: frontStrokes[index]
                            )
                        }
                    } header: {
                        splitHeader(
                            title: "Front",
                            par: frontHoles.reduce(0) { $0 + $1.par },
                            strokes: frontStrokes.reduce(0, +)
                        )
                    }

                    Section {
                        ForEach(backHoles.indices, id: \.self) { index in
                            RoundHoleRow(
                                hole: backHoles[index],
                                strokes: backStrokes[index]
                            )
                        }
                    } header: {
                        splitHeader(
                            title: "Back",
                            par: backHoles.reduce(0) { $0 + $1.par },
                            strokes: backStrokes.reduce(0, +)
                        )
                    }
                } else {
                    Section {
                        ForEach(course.sortedHoles.indices, id: \.self) { index in
                            RoundHoleRow(
                                hole: course.sortedHoles[index],
                                strokes: strokesPerHole[index]
                            )
                        }
                    } header: {
                        splitHeader(
                            title: "Holes",
                            par: course.par,
                            strokes: totalStrokes
                        )
                    }
                }
            }
        }
        .navigationTitle(course?.name ?? "Round")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func splitHeader(title: String, par: Int, strokes: Int) -> some View {
        let diff = strokes - par
        let label: String = diff == 0 ? "E" : (diff > 0 ? "+\(diff)" : "\(diff)")
        return HStack {
            Text(title)
                .textCase(.uppercase)
            Spacer()
            Text("Par \(par) · \(strokes) (\(label))")
                .textCase(.uppercase)
        }
    }
}

#Preview {
    let previewer = Previewer(Round.self, Course.self, Hole.self)
    previewer.addExamples(Course.sampleCourses)
    let course = Course.sampleCourses[0]
    let round = Round(
        date: .now,
        course: course,
        numStrokesPerHole: course.sortedHoles.map { $0.par }
    )
    previewer.addExamples([round])

    return NavigationStack {
        ReadRoundView(round: round)
            .modelContainer(previewer.container)
    }
}
