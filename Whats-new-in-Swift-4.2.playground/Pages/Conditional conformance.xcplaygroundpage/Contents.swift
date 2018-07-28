/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Усовершенствования, касающиеся условного соответствия

 ## Динамические приведения 👻👻 (Dynamic casts)

 Условные соответсвия протоколу ([SE-0143](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md "Conditional conformances")) были заглавной функциональной возможностью Swift 4.1. Последняя часть соответсвующего предложения предложения сThe final piece of the proposal, запрос условных соотвтетвий в runtime, "приземлилась" в Swift 4.2. Это означает динамическое приведение к типу протокола (с использованием `is` или `as?`), где значение условно удовлетворяет протоколу, теперь будет удаваться когда условные требования выполнены.

 Пример:
 */
func isEncodable(_ value: Any) -> Bool {
    return value is Encodable
}

// Это вернуло бы false в Swift 4.1
let encodableArray = [1, 2, 3]
isEncodable(encodableArray)

// Проверим, что динамическая проверка не проходит, если не выполняются критерии соответствия.
struct NonEncodable {}
let nonEncodableArray = [NonEncodable(), NonEncodable()]
assert(isEncodable(nonEncodableArray) == false)

/*:
 ## Синтезированные соответствия в расширениях (extensions)

 Небольшое, но важное усовершенствовоание к синтезируемым компилятором соответствиям протоколу, такое как автоматические соответствия протоколам `Equatable` и `Hashable` предложенные в [SE-0185](https://github.com/apple/swift-evolution/blob/master/proposals/0185-synthesize-equatable-hashable.md "Synthesizing Equatable and Hashable conformance").

 Соответствия протоколам теперь можно синтезировать в расширениях, а не только в определении типа (расширение должно быть в том же файле, что и определение типа). Это больше косметическое изменение, потому что это делает возможным автоматический синтез условных соответствий протоколам `Equatable`, `Hashable`, `Encodable`, и `Decodable`.

 Это пример из [What’s New in Swift session at WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/401/). Мы можем заставить `Either` условно соответствовать протоколам `Equatable` и `Hashable`:
 */
enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

// Код не требуется
extension Either: Equatable where Left: Equatable, Right: Equatable {}
extension Either: Hashable where Left: Hashable, Right: Hashable {}

Either<Int, String>.left(42) == Either<Int, String>.left(42)

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
