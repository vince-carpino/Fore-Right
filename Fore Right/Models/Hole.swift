import Foundation
import SwiftData

@Model
final class Hole {
    var number: Int
    var par: Int

    init(number: Int, par: Int = 4) {
        self.number = number
        self.par = par
    }
}
