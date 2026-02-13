import SwiftUI

@Observable
class NavigationManager {
    static let shared = NavigationManager()

    private init() {}

    var path = NavigationPath()
}
