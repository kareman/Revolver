import Foundation
import Revolver

enum QwopCommand: Character, Discrete, Randomizable {
    case PressQ = "Q"
    case ReleaseQ = "q"
    case PressW = "W"
    case ReleaseW = "w"
    case PressO = "O"
    case ReleaseO = "o"
    case PressP = "P"
    case ReleaseP = "p"
    case Wait = "+"
    
    static let allValues: [QwopCommand] = [
        .PressQ, .ReleaseQ,
        .PressW, .ReleaseW,
        .PressO, .ReleaseO,
        .PressP, .ReleaseP,
        .Wait
    ]
}