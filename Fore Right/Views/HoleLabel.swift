import SwiftUI

struct HoleLabel: View {
    var hole: Hole

    var body: some View {
        Text("Hole")
            .textCase(.uppercase)
        Image(systemName: hole.icon)
    }
}

struct ParLabel: View {
    var hole: Hole

    private var parColor: Color {
        switch hole.par {
        case 3: return .blue
        case 4: return .primary
        default: return .orange
        }
    }

    var body: some View {
        Group {
            Text("Par")
                .textCase(.uppercase)
            Image(systemName: hole.parIcon)
                .contentTransition(.symbolEffect(.replace))
                .foregroundStyle(parColor)
        }
        .animation(.easeInOut(duration: 0.15), value: hole.par)
    }
}
