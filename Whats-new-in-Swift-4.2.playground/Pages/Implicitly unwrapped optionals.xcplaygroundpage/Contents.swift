/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 
 # Неявно развёрнутые (implicitly unwrapped) optionals
 
 [SE-0054](https://github.com/apple/swift-evolution/blob/master/proposals/0054-abolish-iuo.md "Abolish ImplicitlyUnwrappedOptional type") было принято уже в Марте 2016, было полностью реализовано лишь в Swift 4.2.
 
В Swift 4.2, [неявно развёрнутые (implicitly unwrapped) optionals](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID334) по прежнему существуют, то есть вы можете — that is, you can пометить объявляемый тип знаком `!` вместо знака `?` чтобы объявить переменную optional, разворачиваемую автоматически. Но больше нет отдельного типа `ImplicitlyUnwrappedOptional`.
 
 Теперь неявно развёрнутые optionals - это обычные optionals (с типом `Optional<T>`) и особой пометкой, сообщающей компилятору автоматически применять force-unwrap при необходимости.
 
 Есть отличная статья в оффициальном блоге Swift, которая подробно описывает последствия этого изменеия: [Reimplementation of Implicitly Unwrapped Optionals](https://swift.org/blog/iuo/).
 */

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
