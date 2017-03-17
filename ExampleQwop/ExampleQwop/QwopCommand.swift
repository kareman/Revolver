import Foundation
import Revolver

enum QwopCommand: Character, Discrete, Randomizable {
    case pressQ = "Q"
    case releaseQ = "q"
    case pressW = "W"
    case releaseW = "w"
    case pressO = "O"
    case releaseO = "o"
    case pressP = "P"
    case releaseP = "p"
    case wait = "+"
    
    static let allValues: [QwopCommand] = [
        .pressQ, .releaseQ,
        .pressW, .releaseW,
        .pressO, .releaseO,
        .pressP, .releaseP,
        .wait
    ]
}
