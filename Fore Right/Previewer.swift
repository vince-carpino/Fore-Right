import Foundation
import SwiftData

struct Previewer {
    let container: ModelContainer

    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)

        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError(
                "Failed to create Preview container: \(error.localizedDescription)"
            )
        }
    }

    @MainActor
    func addExamples(_ examples: [any PersistentModel]) {
        examples.forEach { example in
            container.mainContext.insert(example)
        }
    }
}
