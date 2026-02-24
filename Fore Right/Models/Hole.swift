import Foundation
import SwiftData

@Model
final class Hole {
    var number: Int
    var par: Int
    var course: Course?
    var icon: String {
        "\(number).circle.fill"
    }
    var parIcon: String {
        "\(par).square"
    }

    static let icon: String = "flag"

    init(number: Int, par: Int = 4) {
        self.number = number
        self.par = par
    }
}
