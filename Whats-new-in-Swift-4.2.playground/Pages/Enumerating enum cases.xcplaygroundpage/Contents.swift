/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Перечисление всех cases enum 

 [SE-0194 — Derived Collection of Enum Cases](https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md "Derived Collection of Enum Cases"): Компилятор может автоматически генерировать свойство `allCases` для перечислений enums, обеспечивая вас постоянно актуальным списком всех enum cases. Всё, что для этого нужно - это чтобы ваш enum соответствовал новому протоколу `CaseIterable`.
 */
enum Terrain: CaseIterable {
    case water
    case forest
    case desert
    case road
}

Terrain.allCases
Terrain.allCases.count

/*:
 Обратите внимание, что автоматический синтез работает только для enum без связанных значений (associated values) - потому, что связанные значения позволяют перечислению enum потенциально иметь бесконечное число возможных значений.


 При желании, вы можете вручную реализовать протокол, если список возможных значений конечный.
 В качестве примера, вот условное соответствие протоколу для завёрнутых в Optionals типов, при том, что сами эти типы соответствуют `CaseIterable`:
 */
extension Optional: CaseIterable where Wrapped: CaseIterable {
    public typealias AllCases = [Wrapped?]
    public static var allCases: AllCases {
        return Wrapped.allCases.map { $0 } + [nil]
    }
}

// Обратите внимание: это не цепочка optional (optional chaining)!
// Мы обращаемся к переменной типа Optional<Terrain>.
Terrain?.allCases
Terrain?.allCases.count

/*:
 (Эксперимент забавный, но я сомневаюсь, что подобная реализация будет полезна на практике. Используйте с осторожностью.)
 */
/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
