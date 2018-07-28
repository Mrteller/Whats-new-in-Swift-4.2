/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # `MemoryLayout.offset(of:)`

 [SE-0210](https://github.com/apple/swift-evolution/blob/master/proposals/0210-key-path-offset.md "Add an offset(of:) method to MemoryLayout") добавляет метод `offset(of:)` к типу `MemoryLayout`, дополняня существующий API для получения размера, шага (stride) и выравнивания типа.

 Метод `offset(of:)` принимает в качестве аргумента ключевой путь (key path) к сохраненному свойству типа и возвращает байтовое смещение свойства. Примером, где это полезно, является передача массива значений чередующихся пикселей в графический API.
 */
struct Point {
    var x: Float
    var y: Float
    var z: Float
}

MemoryLayout<Point>.offset(of: \Point.z)

/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
