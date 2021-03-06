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
Этот API аккуратно оберегает вас от распростаненных ошибок при генерировании случайных чисел, таких как [смещение по модулю] (https://www.quora.com/What-is-modulo-bias).

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

 Если у вас особые требования, вы можете реализовать свой собственный генератор случайных чисел, приняв протокол `RandomNumberGenerator`. Все API для генерации случайных значений обеспечивают перегрузку, которая позволяет пользователям передавать предпочитаемый генератор случайных чисел:
 */
/// Фиктивный (для примера) генератор случайных чисел, который просто имитирует `Random.default`.
struct MyRandomNumberGenerator: RandomNumberGenerator {
    var base = SystemRandomNumberGenerator()
    mutating func next() -> UInt64 {
        return base.next()
    }
}

var customRNG = MyRandomNumberGenerator()
Int.random(in: 0...100, using: &customRNG)

/*:
 ## Расширение собственных типов

 Можно предоставить API случайных данных для собственных типов, следуя тому же шаблону:
 */
enum Suit: String, CaseIterable {
    case diamonds = "♦"
    case clubs = "♣"
    case hearts = "♥"
    case spades = "♠"

    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Suit {
        // Использование CaseIterable для реализации
        return allCases.randomElement(using: &generator)!

    }

    static func random() -> Suit {
        var rnd = SystemRandomNumberGenerator()
        return Suit.random(using: &rnd)
    }
}

let randomSuit = Suit.random()
randomSuit.rawValue

/*:
 Автор написал более подробную статью о random APIs: [Random numbers in Swift](https://oleb.net/blog/2018/06/random-numbers-in-swift/).
 */

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
