import SwiftData
import SwiftUI

struct HoleInputRow: View {
    var hole: Hole
    @Binding var strokes: Int
    @State private var countsDown = false

    private var relativeToPar: Int { strokes - hole.par }

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
        HStack {
            Text("Hole".uppercased())
            Image(systemName: hole.icon)

            Text("Par".uppercased())
            Image(systemName: hole.parIcon)

            Spacer()

            Text(relativeLabel)
                .foregroundStyle(relativeColor)
                .monospacedDigit()
                .contentTransition(.numericText(countsDown: countsDown))
                .animation(.default, value: strokes)
                .padding(.trailing)

            Stepper(
                "",
                value: Binding(
                    get: { strokes },
                    set: { newValue in
                        countsDown = newValue < strokes
                        strokes = newValue
                    }
                ),
                in: 1...9
            )
            .labelsHidden()
            .sensoryFeedback(.increase, trigger: strokes)
        }
        .bold()
        .font(.title3)
    }
}

#Preview {
    let previewer = Previewer(Round.self, Course.self, Hole.self)
    let hole = Hole(number: 3, par: 4)
    previewer.addExamples([hole])

    return HoleInputRow(hole: hole, strokes: .constant(5))
        .modelContainer(previewer.container)
        .padding()
}
