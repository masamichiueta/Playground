//: [Previous](@previous)

import Foundation

let test = "まさみち雅道マサミチ😋masamichi"
let test2 = "2221129383aa!. .sda[1[aa k sj dffl sjak flsdjflsjlsdj"

extension String {
    func startWithJapanese(numberOfCharacter: Int) -> Bool {
        let hiraganaFirst = UnicodeScalar(0x3041)!
        let hiraganaLast = UnicodeScalar(0x3093)!

        let katakanaFirst = UnicodeScalar(0x30A1)!
        let katakanaLast = UnicodeScalar(0x30F6)!

        let kanjiFirst = UnicodeScalar(0x4E00)!
        let kanjiLast = UnicodeScalar(0x9FA0)!

        print(kanjiFirst)
        print(kanjiLast)

        let unicodeScalarsToCheck = self.unicodeScalars.prefix(numberOfCharacter)
        for unicodeScalar in unicodeScalarsToCheck {
            if hiraganaFirst <= unicodeScalar && unicodeScalar <= hiraganaLast {
                return true
            } else if katakanaFirst <= unicodeScalar && unicodeScalar <= katakanaLast {
                return true
            } else if kanjiFirst <= unicodeScalar && unicodeScalar <= kanjiLast {
                return true
            }
        }

        return false
    }
}

print(test.startWithJapanese(numberOfCharacter: 20))
print(test2.startWithJapanese(numberOfCharacter: 20))