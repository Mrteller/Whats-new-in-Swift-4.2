/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Реконструкция `Hashable`

 Синтезируемые компилятором соответствия протоколам `Equatable` и `Hashable`, введённые в Swift 4.1 ([SE-0185](https://github.com/apple/swift-evolution/blob/master/proposals/0185-synthesize-equatable-hashable.md "Synthesizing Equatable and Hashable conformance")) разительно сокращают количество реализаций `Hashable`, которые вы должны писать вручную.

 Но, если вам нужно кастомизировать для типа соответствие протоколу `Hashable`, то реконструция протокола `Hashable` ([SE-0206](https://github.com/apple/swift-evolution/blob/master/proposals/0206-hashable-enhancements.md "Hashable Enhancements")) делает эту задачу намного проще.

 В мире нового `Hashable` вместо того чтобы реализовывать `hashValue`, теперь вам требуется реализовать метод `hash(into:)`. Этот метод предоставляет объект `Hasher`, и все, что вам нужно сделать в вашей реализации, - это передать ему значения, которые вы хотите включить в свое хэш-значение, многократно вызывая `hasher.combine(_:)`.

 Преимущество перед прежним способом заключается в том, что вам не нужно придумывать свой собственный алгоритм для объединения хэш-значений, из которых состоит ваш Тип. Хэш-функция, предоставляемая стандартной библиотекой (в виде `Hasher`), почти наверняка лучше и безопаснее, чем все, что большинство из нас напишет.

 В качестве примера здесь приводится Тип с одним хранимым свойством, выполняющем роль кэша для дорогостоящих вычислений. При этом нам следует игнорировать значение `distanceFromOrigin` в наших реализациях `Equatable` и `Hashable`:
 */
struct Point {
    var x: Int { didSet { recomputeDistance() } }
    var y: Int { didSet { recomputeDistance() } }

    /// Кешировано. Должно игнорироваться Equatable and Hashable [иначе теряется смысл кеширования].
    private(set) var distanceFromOrigin: Double

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        self.distanceFromOrigin = Point.distanceFromOrigin(x: x, y: y)
    }

    private mutating func recomputeDistance() {
        distanceFromOrigin = Point.distanceFromOrigin(x: x, y: y)
    }

    private static func distanceFromOrigin(x: Int, y: Int) -> Double {
        return Double(x * x + y * y).squareRoot()
    }
}

extension Point: Equatable {
    static func ==(lhs: Point, rhs: Point) -> Bool {
        // При определении равенства distanceFromOrigin не учитывается
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

/*:
 В нашей реализации `hash(into:)`, всё что нам нужно сделать это передать релевантные свойства аргументу hasher.

  Это проще (и эффективнее), чем придумывать собственную функцию комбинирования хэша. Например, наивная реализация для 'hashValue` могла бы представлять собой XOR двух координат: `return x ^ y`. Это было бы менее эффективной хэш-функцией (чем стандартная), потому что `Point(3, 4)` и `Point(4, 3)` окажутся с одинаковым хэш-значением. 
 */
extension Point: Hashable {
    func hash(into hasher: inout Hasher) {
        // distanceFromOrigin игнорируется для хеширования
        hasher.combine(x)
        hasher.combine(y)
    }
}

let p1 = Point(x: 3, y: 4)
p1.hashValue
let p2 = Point(x: 4, y: 3)
p2.hashValue
assert(p1.hashValue != p2.hashValue)

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
