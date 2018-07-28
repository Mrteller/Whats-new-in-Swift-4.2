/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous)

 # Вызов `withUnsafePointer(to:_:)` с `withUnsafeBytes(of:_:)` с неизменяемыми значениями (immutable values)

 Это мелочь, но если вам когда-либо приходилось использовать функции верхнего уровня `withUnsafePointer(to:_:)` и `withUnsafeBytes(of:_:)`, вы, возможно, заметили, что они требовали, чтобы их аргумент был изменяемым значением, потому что параметр был `inout`.

 [SE-0205](https://github.com/apple/swift-evolution/blob/master/proposals/0205-withUnsafePointer-for-lets.md "withUnsafePointer(to:_:) and withUnsafeBytes(of:_:) for immutable values") добавляет перегрузки (overloads), работающие с неизменяемыми значениями (immutable values).
 */
let x: UInt16 = 0xabcd
let (firstByte, secondByte) = withUnsafeBytes(of: x) { ptr in
    (ptr[0], ptr[1])
}
String(firstByte, radix: 16)
String(secondByte, radix: 16)

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous)
 */
