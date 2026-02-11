import Foundation
import SwiftUI

struct PrimaryButton: View {
    var label: String
    var action: () -> Void = { }

    var body: some View {
        Button {
            action()
        } label: {
            Text(label.uppercased())
                .foregroundStyle(.white)
                .bold()
                .font(.title)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    PrimaryButton(label: "Test")
}
