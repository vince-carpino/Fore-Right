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
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    PrimaryButton(label: "Some button text")
}
