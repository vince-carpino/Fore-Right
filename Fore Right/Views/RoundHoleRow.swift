import SwiftData
import SwiftUI

struct RoundHoleRow: View {
    var hole: Hole
    var strokes: Int

    private var isUnderPar: Bool {
        strokes < hole.par
    }
    private var currentSymbolName: String {
        let difference = strokes - hole.par

        switch difference {
        case -1: return "star.fill"
        case -2: return "flame.fill"
        case ..<(-2): return "crown.fill"
        default: return ""
        }
    }

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
            HoleLabel(hole: hole)
            ParLabel(hole: hole)

            Spacer()

            Image(systemName: currentSymbolName)
                .font(.callout)
                .foregroundStyle(.yellow)
                .opacity(isUnderPar ? 1 : 0)
                .scaleEffect(isUnderPar ? 1 : 0.5)

            Text(relativeLabel)
                .foregroundStyle(relativeColor)
                .monospacedDigit()
                .padding(.trailing)

//            Text("\(strokes)")
//                .frame(minWidth: 24)
        }
        .bold()
        .font(.title3)
    }
}

#Preview {
    let previewer = Previewer(Round.self, Course.self, Hole.self)
    let hole = Hole(number: 3, par: 4)
    previewer.addExamples([hole])

    return RoundHoleRow(hole: hole, strokes: 3)
        .modelContainer(previewer.container)
        .padding()
}
