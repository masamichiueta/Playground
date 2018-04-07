//: [Previous](@previous)

import Foundation

struct QuestionStatus: OptionSet {
    let rawValue: Int

    static let initial = QuestionStatus(rawValue: 1 << 0)
    static let modified = QuestionStatus(rawValue: 1 << 1)
    static let answered = QuestionStatus(rawValue: 1 << 10)
    static let declined = QuestionStatus(rawValue: 1 << 11)
    static let refunded = QuestionStatus(rawValue: 1 << 12)
    static let canceled = QuestionStatus(rawValue: 1 << 20)
    static let closed = QuestionStatus(rawValue: 1 << 21)
}

let a = QuestionStatus(rawValue: 1)
print(a == .initial)
print(a.rawValue) 


let b = QuestionStatus(rawValue: 2049)
print(b.contains(.canceled))

let c: QuestionStatus = [.declined, .initial, .answered]

print(c.contains(b))
print(b.contains(c))

print(c.isSubset(of: b))
print(b.isSubset(of: c))

let d = QuestionStatus(rawValue: 1025)
print(d)
print(d.contains(.answered))


var e: QuestionStatus = [.initial, .answered, .closed]
print(e.rawValue)

e.insert(.closed)
print(e.rawValue)

var f: QuestionStatus = [.initial, .declined, .refunded]
print(f.rawValue)

var g = "aaa"
var h = g.characters.prefix(64)
print(String(h))

let countryIsoCode = Locale.current.regionCode
let identifiers = Locale.availableIdentifiers.filter({$0.contains("j")})
print(identifiers)
print(countryIsoCode)