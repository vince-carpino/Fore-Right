import SwiftUI

struct NoListItemsView: View {
    var title: String = ""
    var icon: String = ""
    var description: String = ""
    var buttonText: String = ""
    var buttonIcon: String = ""
    var buttonAction: () -> Void = { }

    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: icon)
                .foregroundStyle(Color.accent)
        } description: {
            Text(description)
        } actions: {
            Button(action: buttonAction) {
                Label(buttonText, systemImage: buttonIcon)
                    .bold()
                    .padding(5)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NoListItemsView(
        title: "No items to show",
        icon: "flame.fill",
        description: "You haven't added any items yet.",
        buttonText: "Add an Item",
        buttonIcon: "plus.circle.fill",
    )
}
