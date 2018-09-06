/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)

 # Динамический поиск членов (Dynamic member lookup)

 [SE-0195](https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md "Introduce User-defined 'Dynamic Member Lookup' Types") вводит атрибут `@dynamicMemberLookup` для деклараций типов.

 Переменная типа `@dynamicMemberLookup` может вызываться с любым геттером (accessor) свойств (используя точечную нотацию) - компилятор не станет проверять существует ли член с указанным именем или нет. Вместо этого компилятор превращает такие обращения в вызовы геттера по сабскрипту, которому передается имя члена в виде строки.

 Цель этой функции - обеспечить совместимость между Swift и динамическими языками, такими как Python. Команда [Swift for Tensorflow](https://github.com/tensorflow/swift) в Google, выдвинувшая это предложение, реализовала мост Python, который делает возможным вызвать код Pyton из Swift [call Python code from Swift](https://github.com/tensorflow/swift/blob/master/docs/PythonInteroperability.md). Pedro José Pereira Vieito запаковал это в SwiftPM package названный [PythonKit](https://github.com/pvieito/PythonKit).

 SE-0195 не является обязательным для обеспечения такой совместимости, но делает получаемый синтакс Swift намного аккуратнее. Стоит отметить, что SE-0195 имеет дело только с поиском property-style членов (т.е. простых геттеров и сеттеров без аргументов). Второе предложение, "динамически вызываемое" ("dynamic callable") для синтаксиса вызова динамического метода всё ещё в работе.

 Хотя Python был в центре внимания людей, которые работали над этим предложением, прослойки для взаимодействия с другими динамическими языками, такими как Ruby или JavaScript, также смогут воспользоваться им.

И это также не единственный вариант использования. Любой тип, который в настоящее время имеет стиль API со строками в сабскрипте (string-based subscript-style API), может быть преобразован в стиль динамического поиска членов (dynamic member lookup style). SE-0195 показывает Тип `JSON` в качестве примера, где вы можете детализировать вложенные словари, используя точечную нотацию.

 Вот еще один пример, любезно предоставленный Дугом Грегором: Тип `Environment`, который дает вам property-style доступ к переменным среды вашего процесса. Обратите внимание, что мутации также работают.
 */
import Darwin

/// Среда (environment) текущего процесса.
///
/// - Author: Doug Gregor, https://gist.github.com/DougGregor/68259dd47d9711b27cbbfde3e89604e8
@dynamicMemberLookup
struct Environment {
    subscript(dynamicMember name: String) -> String? {
        get {
            guard let value = getenv(name) else { return nil }
            return String(validatingUTF8: value)
        }
        nonmutating set {
            if let value = newValue {
                setenv(name, value, /*overwrite:*/ 1)
            } else {
                unsetenv(name)
            }
        }
    }
}

let environment = Environment()

environment.USER
environment.HOME
environment.PATH

// Мутации допускаются, если у сабскрипта есть сеттер
environment.MY_VAR = "Hello world"
environment.MY_VAR

/*:

 Это большая особенность, имеющая потенциал, способный изменить, использование Swift фундаментальным образом, если применять эту особенность неправильно. Скрывая принципиально "небезопасный"  доступ на основе строк (string-based access) за кажущейся "безопасной" конструкцией, вы можете создать у читателей вашего кода неправильное впечатление, что компилятор всё проверил.
 
 Прежде чем вы примете подобные конструкции в своем собственном коде, спросите себя, действительно ли `environment.USER` намного более читабелен, чем `environment["USER"]`, чтобы быть привносить сопутствующие проблемы. В большинстве ситуаций, я думаю, что ответ должен быть "нет".
 */
/*:
 [Оглавление](Table%20of%20contents) • [Предыдущая страница](@previous) • [Следущая страница](@next)
 */
