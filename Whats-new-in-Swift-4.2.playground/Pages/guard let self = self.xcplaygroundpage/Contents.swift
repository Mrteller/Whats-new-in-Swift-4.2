/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 
 # `guard let self = self`
 
 [SE-0079](https://github.com/apple/swift-evolution/blob/master/proposals/0079-upgrade-self-from-weak-to-strong.md "Allow using optional binding to upgrade self from a weak to strong reference") ещё одно предложение, притятое ещё Swift 3.0, реализация которого затянулась.
 
 Оно позволяет заново связать слабый `self` из weak (и optional) переменной со strong переменной, используя optional binding. Теперь вы можете написать `if let self = self { … }` или `guard let self = self else { … }` внутри замыкания, захватившего weak `self`, чтобы условно связать заново `self` с strong переменной внутри конструкции (и в границах) `if let` or `guard let`. То есть сделать из слабого self захваченного замыканием, сильный внутри `if let` or `guard let`.
 */

import Dispatch

struct Book {
    var title: String
    var author: String
}

func loadBooks(completion: @escaping ([Book]) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        DispatchQueue.main.async {
            completion([
                Book(title: "Harry Potter and the Deathly Hallows", author: "JK Rowling"),
                Book(title: "Pippi Långstrump", author: "Astrid Lindgren")])
        }
    }
}

class ViewController {
    var items: [Book] = []
    
    func viewDidLoad() {
        loadBooks { [weak self] books in
            // This is now allowed
            guard let self = self else {
                return
            }
            self.items = books
            self.updateUI()
        }
    }
    
    func updateUI() {
        // ...
    }
}

/*:
 В прежних версиях Swift можно было подобным образом заново связать `self` и сделать его сильным взяв self в обратные апострофы, и многие разработчики пользовались этим, даже придумали специальное имя для такого случая: `strongSelf`. Однако, тот факт, что это работало, являлся [багом, а не фичей](https://github.com/apple/swift-evolution/blob/master/proposals/0079-upgrade-self-from-weak-to-strong.md#relying-on-a-compiler-bug).
 */
/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */

