import SwiftUI

struct NoListItemsView<Destination: View>: View {
    var title: String = ""
    var icon: String = ""
    var description: String = ""
    var buttonText: String = ""
    var buttonIcon: String = ""
    var destination: Destination

    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: icon)
                .foregroundStyle(Color.accent)
        } description: {
            Text(description)
        } actions: {
            NavigationLink(destination: destination) {
                Label(buttonText, systemImage: buttonIcon)
                    .bold()
                    .padding()
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
        destination: Text("Destination View")
    )
}
