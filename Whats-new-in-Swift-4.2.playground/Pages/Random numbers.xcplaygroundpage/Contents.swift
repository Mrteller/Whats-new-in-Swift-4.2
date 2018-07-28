/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Случайные числа

 Работа со случайными числами была слегка болезненна в Swift, поскольку вам (a) приходилось напрямую вызывать C APIs и (b) не было хорошего кросс-платформенного API для случайных чисел.

 [SE-0202](https://github.com/apple/swift-evolution/blob/master/proposals/0202-random-unification.md "Random Unification") добаляет генерирование случайных чисел в стндартную библиотеку.

 ## Генерирование случайных чисел

 Все числовые типы теперь имеют метод `random(in:)`, который возвращает случайное число в указанном диапазоне (по-умолчанию используется равномерное распределение):
 */
Int.random(in: 1...1000)
UInt8.random(in: .min ... .max)
Double.random(in: 0..<1)

/*:
Этот API аккуратно оберегает вас от распростаненных  ошибок при генерировании случайных чисел [смещение по модулю] (https://www.quora.com/What-is-modulo-bias).

 `Bool.random` это тоже вещь:
 */
func coinToss(count tossCount: Int) -> (heads: Int, tails: Int) {
    var tally = (heads: 0, tails: 0)
    for _ in 0..<tossCount {
        let isHeads = Bool.random()
        if isHeads {
            tally.heads += 1
        } else {
            tally.tails += 1
        }
    }
    return tally
}

let (heads, tails) = coinToss(count: 100)
print("100 подбрасываний монеты — орёл: \(heads), решка: \(tails)")

/*:
 ## Случайные элементы коллекции (`Collection`)

 Коллекции (`Collections`) получают метод `randomElement` (который возвращает optional если коллекция пуста, также как это делают `min` and `max`):
 */
let emotions = "😀😂😊😍🤪😎😩😭😡"
let randomEmotion = emotions.randomElement()!

/*:
 Используйте метод `shuffled`, чтобы перетасовать последовательность `Sequence` или коллекцию:
 */
let numbers = 1...10
let shuffled = numbers.shuffled()

/*:
 Есть и изменяющий (mutating) вариант под названием `shuffle`. Он доступен на всех типах, соответвующих протоколам `MutableCollection` и `RandomAccessCollection`:
 */
var mutableNumbers = Array(numbers)
// Перемешивает на месте
mutableNumbers.shuffle()

/*:
 ## Пользовательские нестандарные генераторы случайных чисел

 Стандартная библиотека поставляется с генератором случайных чисел по-умолчанию `Random.default`, который, возможно, является хорошим выбором для большинства простых случаев.

 If you have special requirements, you can implement your own random number generator by adopting the `RandomNumberGenerator` protocol. All APIs for generating random values provide an overload that allows users to pass in their preferred random number generator:
 */
/// A dummy random number generator that just mimics `Random.default`.
struct MyRandomNumberGenerator: RandomNumberGenerator {
    var base = Random.default
    mutating func next() -> UInt64 {
        return base.next()
    }
}

var customRNG = MyRandomNumberGenerator()
Int.random(in: 0...100, using: &customRNG)

/*:
 ## Extending your own types

 You can provide a random data API for your own types by following the same pattern:
 */
enum Suit: String, CaseIterable {
    case diamonds = "♦"
    case clubs = "♣"
    case hearts = "♥"
    case spades = "♠"

    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Suit {
        // Using CaseIterable for the implementation
        return allCases.randomElement(using: &generator)!

    }

    static func random() -> Suit {
        return Suit.random(using: &Random.default)
    }
}

let randomSuit = Suit.random()
randomSuit.rawValue

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
