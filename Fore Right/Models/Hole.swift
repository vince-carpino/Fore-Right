import Foundation
import SwiftData

@Model
final class Hole {
    var number: UInt8
    var yardage: UInt8
    var par: UInt8
    var handicap: UInt8?

    init(number: UInt8, yardage: UInt8, par: UInt8, handicap: UInt8? = nil) {
        self.number = number
        self.yardage = yardage
        self.par = par
        self.handicap = handicap
    }
}
