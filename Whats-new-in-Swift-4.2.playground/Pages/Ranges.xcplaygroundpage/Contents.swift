/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 
 # Исключение `CountableRange` и `CountableClosedRange`
 
 Введние условных соответсвий протоколу ([SE-0143](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md "Conditional conformances")) в Swift 4.1 позволило стандартной библиотеке избавиться от множества типов, которые до того были необходимы, но чья функциональность отныне могла быть выражена в виде ограниченных (типом) расширений (extensions) базового типа.
 
 Например, функциональность `MutableSlice<Base>` теперь включена в “обычный” `Slice<Base>` наряду с `расширением extension Slice: MutableCollection where Base: MutableCollection`
 
 Swift 4.2 вводит аналогичную консолидацию для диапазонов. прежде отдельные типы `CountableRange` and `CountableClosedRange` исключены в пользу условных соответсвий для `Range` и `ClosedRange`.
 
 Цель типов счётных диапазонов (countable range types) состояла в том, чтобы позволить диапазону стать коллекцией, если тип лежащего в основе элемента был _счётным(countable)_ (т.е. удовлетворял протоколу `Strideable` и использовал целые (signed) числа для шага (striding). Так например, диапазоны целых могут быть коллекциями, а вот диапазоны чисел с плавающей точкой - не могут.
 */

let integerRange: Range = 0..<5
// Мы можем на диапазоне целых применить map, посколько это ведь Collection
let integerStrings = integerRange.map { String($0) }
integerStrings

let floatRange: Range = 0.0..<5.0
// А вот это вызвало бы ошибку, поскольку диапазон Doubles не является Collection
//floatRange.map { String($0) } // error!

/*:
 Сами имена `CountableRange` и `CountableClosedRange` всё ещё существуют; они были сконвертированы в typealiases для совместимости. Но в дальнейшем, в новом коде их не следует больше использовать.
 
 The distinction between half-open `Range` and closed ranges `ClosedRange` still exists on the type system level because it cannot be eliminated so easily. A `ClosedRange` can never be empty and a `Range` can never contain the maximum value of its element type (e.g. `Int.max`). Moreover, the difference is important for non-countable types: it’s not trivial to rewrite a range like `0.0...5.0` into an equivalent half-open range.
 */
/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */

