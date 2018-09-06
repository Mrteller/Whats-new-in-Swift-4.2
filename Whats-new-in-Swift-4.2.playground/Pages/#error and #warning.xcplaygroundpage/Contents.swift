/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Директивы `#error` и `#warning`

 [SE-0196](https://github.com/apple/swift-evolution/blob/master/proposals/0196-diagnostic-directives.md "Compiler Diagnostic Directives") вводит директивы `#error` и `#warning` для инициирования ошибки или предупреждения при сборке исходного кода.

  Например, используйте `#warning`, чтобы не забыть важное действие TODO перед, тем как зафиксировать код:
 */
func doSomethingImportant() {
    #warning("TODO: отсутствует реализация")
}
doSomethingImportant()

/*:
 `#error` может пригодиться, если ваш код не поддерживает определённые среды (environments):
 */
#if canImport(UIKit)
    // ...
#elseif canImport(AppKit)
    // ...
#else
    #error("Для этого playground требуется UIKit или AppKit")
#endif

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
