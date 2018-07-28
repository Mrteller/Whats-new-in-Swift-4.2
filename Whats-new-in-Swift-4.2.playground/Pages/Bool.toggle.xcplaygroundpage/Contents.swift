/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Bool.toggle

 [SE-0199](https://github.com/apple/swift-evolution/blob/master/proposals/0199-bool-toggle.md "Adding toggle to Bool") добавляет изменяющий (mutating) метод `toggle` к `Bool`.

 Это особенно полезно, когда требуется "переключать" значение boolean глубоко внутри вложенной структуры данных, поскольку не требуется повторять одно и то же выражение на обеих сторонах оператора присваивания.
 */
struct Layer {
    var isHidden = false
}

struct View {
    var layer = Layer()
}

var view = View()

// Раньше:
view.layer.isHidden = !view.layer.isHidden
view.layer.isHidden

// Теперь:
view.layer.isHidden.toggle()

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
