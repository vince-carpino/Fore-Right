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

    var body: some View {
        Text("Par")
            .textCase(.uppercase)
        Image(systemName: hole.parIcon)
    }
}
