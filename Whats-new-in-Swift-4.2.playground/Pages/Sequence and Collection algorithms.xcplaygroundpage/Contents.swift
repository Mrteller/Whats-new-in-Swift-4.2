/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Алгоритмы для Sequence и Collection

 ## `allSatisfy`

 [SE-0207](https://github.com/apple/swift-evolution/blob/master/proposals/0207-containsOnly.md "Add an allSatisfy algorithm to Sequence") добавляет алгоритм `allSatisfy` к последовательности `Sequence`. `allSatisfy` возвращает `true` только тогда, когда ВСЕ элементы последовательности удовтеворяют предикату. Эта фукция часто называется просто `all` в других функциональных языках программирования.

 `allSatisfy` прекрасно дополняет `contains(where:)`, которая позволяет выяснить удовлетворяет ли хотя бы один элемент предикату.
 */
let digits = 0...9

let areAllSmallerThanTen = digits.allSatisfy { $0 < 10 }
areAllSmallerThanTen

let areAllEven = digits.allSatisfy { $0 % 2 == 0 }
areAllEven

/*:
 ## `last(where:)`, `lastIndex(where:)` и `lastIndex(of:)`

 [SE-0204](https://github.com/apple/swift-evolution/blob/master/proposals/0204-add-last-methods.md "Add last(where:) and lastIndex(where:) Methods") добавляет метод `last(where:)` к последовательности `Sequence` и добавляет методы `lastIndex(where:)` и `lastIndex(of:)` к коллекции `Collection`.
 */
let lastEvenDigit = digits.last { $0 % 2 == 0 }
lastEvenDigit

let text = "Пойдем на пляж"

let lastWordBreak = text.lastIndex(where: { $0 == " " })
let lastWord = lastWordBreak.map { text[text.index(after: $0)...] }
lastWord

text.lastIndex(of: " ") == lastWordBreak

/*:
 ### Переименование `index(of:)` и `index(where:)` в `firstIndex(of:)` и `firstIndex(where:)`

 Для единообразия SE-0204 также переименовывает `index(of:)` и `index(where:)` в `firstIndex(of:)` и `firstIndex(where:)`.

 */
let firstWordBreak = text.firstIndex(where: { $0 == " " })
let firstWord = firstWordBreak.map { text[..<$0] }
firstWord

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
