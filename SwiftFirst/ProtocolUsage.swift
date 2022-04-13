//
//  ProtocolUsage.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/6.
//协议

import Foundation

//协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储属性还是计算属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的
//协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示
//在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性
protocol protocolName {
    //可读，可写
    var mustBeSettable: Int { get set }
    //只读
    var doesNotNeedToBeSettable: Int { get }
    //可读写的类属性
    static var someTypeProperty: Int {set get}
}

protocol FullyName {
    var fullName:String {get}
}

//遵守了FullyName协议，意味着Person内部必须有一个String类型的fullName属性
struct Person:FullyName {
    var fullName: String
    
    static func usage() {
        let p = Person.init(fullName: "John")
        print(p.fullName)
    }
}

//这里是通过一个可读属性遵守了协议
struct Starship:FullyName {
    var prefix:String?
    var name:String
    
    init(name:String, prefix:String?) {
        self.prefix = prefix
        self.name = name
    }
    
    var fullName: String {
        if let p = prefix {
            return p + " " + name
        }else {
            return name
        }
    }
    
    static func usage() ->Void {
        let star = Starship.init(name: "Nemo", prefix: "Desmond")
        print(star.fullName)
    }
}

//在协议中要求方法
protocol ProtocolWithMethod {
    //在协议中声明类方法，只能用static，不能用class关键字
    static func someTypeMethod(ii:Int) ->Double
    //声明实例方法
    func someInstanceMethod(ii:Double) -> Double
}

//随机数生成协议：
protocol RandomNumGenerator {
    func random() -> Double
}

//线性同余位随机数生成器
class LinearCongruentialGenerator: RandomNumGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = (lastRandom * a * c.truncatingRemainder(dividingBy: m))
        return lastRandom/m
    }
    
    static func usage() ->Void {
        
        
        let li = LinearCongruentialGenerator.init()
        print(li.random())
    }
}

protocol Togglable {
    //mutaing关键字，可以让值类型的对象的方法可以改变属性值，表明改方法可能回改变属性值
    mutating func toggle()
}

enum OnOffSwitch:Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
    
    static func usage() {
        var lightSwitch = OnOffSwitch.off
        lightSwitch.toggle()
        lightSwitch.toggle()
        print(lightSwitch)
    }
}

protocol ProtocolWithInit {
    init(someParameter: Int)
}

class ClassObeyInitProtocol: ProtocolWithInit {
    //协议要求的构造器，前面都要有一个required关键字, 如果这个类被final修饰的话，就不需要在构造器前加required
    //协议要求为init，那么实现不能是init?, 其他几种init都可以互相替代
    required init(someParameter: Int) {
        
    }
}

class Dice {
    let sides:Int
    //一个遵守协议的属性
    let generator: RandomNumGenerator
    
    init(sides:Int, generator:RandomNumGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

protocol DiceGame {
    var dice:Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game:DiceGame)
    func game(_ game:DiceGame, didSatrtNewTurnWithRoll diceRoll:Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice: Dice = Dice.init(sides: 6, generator: LinearCongruentialGenerator.init())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array.init(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate:DiceGameDelegate?
    func play() {
        square = 0
        //通知代理游戏开始，如果代理为空，那么通知失败
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didSatrtNewTurnWithRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
            continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

//蛇梯游戏的代理，遵守DiceGameDelegate协议
class DiceGameTracker: DiceGameDelegate {
    var numOfTurns = 0
    //游戏开始时调用
    func gameDidStart(_ game: DiceGame) {
        numOfTurns = 0
        if game is SnakesAndLadders {
            print("Satrted a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    //游戏进行一轮时调用
    func game(_ game: DiceGame, didSatrtNewTurnWithRoll diceRoll: Int) {
        numOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    //游戏结束时调用
    func gameDidEnd(_ game: DiceGame) {
        print("THe game lasted for \(numOfTurns) turns")
    }
}

//扩展中使用协议：
protocol TextRepresentable {
    var textualDescription: String { get }
}

//对Dice类进行扩展，使其遵守TextRepresentable协议
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

//MARK: - 有条件地遵循协议：
//下面的扩展让 Array 类型只要在存储遵循 TextRepresentable 协议的元素时就遵循 TextRepresentable 协议。
extension Array :TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemAsText = self.map {
            $0.textualDescription
        }
        return "[" + itemAsText.joined(separator: ", ") + "]"
    }
    
    static func usage() {
        let myDice = [Dice.init(sides: 6, generator: LinearCongruentialGenerator.init()), Dice.init(sides: 12, generator: LinearCongruentialGenerator.init())]
        //因为myDice的数组元素也遵循TextRepresentable协议，所以此时myDice也遵循该协议
        print(myDice.textualDescription)
    }
}

//MARK: - 在扩展里声明采纳协议
//当一个类型已经遵循了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空的扩展来让它采纳该协议
struct Hamster {
    var name:String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
    
    func usage() -> Void {
        let simonTheHamster = Hamster.init(name: "Simon")
        //因为simonTheHamster在扩展中遵循TextRepresentable协议，所以赋值可以成功
        let somethingTextRepresentable:TextRepresentable = simonTheHamster
        print(somethingTextRepresentable.textualDescription)
    }
}
//因为Hamster以及实现了TextRepresentable的要求，所以通过一个空的扩展即可声明Hamster遵守协议
extension Hamster:TextRepresentable {}

//MARK: - 使用合成实现来采纳协议
//遵循Equatable, 就可以通过==来判定是否相等
//Swift 为以下几种自定义类型提供了 Equatable 协议的合成实现：
/*
 遵循 Equatable 协议且只有存储属性的结构体。
 遵循 Equatable 协议且只有关联类型的枚举
 没有任何关联类型的枚举
 */
//也就是说只要声明遵循了Equatable协议后，不需要实现额外的代码就可以通过==、!= 判定是否相等
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
    
    static func usage() {
        let twoOneTwo1 = Vector3D.init(x: 2, y: 1, z: 2)
        let twoOneTwo2 = Vector3D.init(x: 2, y: 1, z: 2)
        if twoOneTwo1 == twoOneTwo2 {
            print("These two vector3Ds is equivalent.")
        }else {
            print("These two vector3Ds is not equivalent.")
        }
        
    }
}

//Swift 为以下几种自定义类型提供了 Hashable 协议的合成实现：
/*
 遵循 Hashable 协议且只有存储属性的结构体。
 遵循 Hashable 协议且只有关联类型的枚举
 没有任何关联类型的枚举
*/
//在包含类型原始声明的文件中声明对 Hashable 协议的遵循，可以得到 hash(into:) 的合成实现，且无需自己编写任何关于 hash(into:) 的实现代码

//这边SkillLevel遵守了Comparable协议，那么它就可以通过>, >=, <, <=, 进行比较了，根据枚举的位置来确定大小
enum SkillLevel:Comparable {
    case beginner
    case intermediate
    case expert(stars:Int)
    
    static func usage() -> Void {
        let levels = [SkillLevel.intermediate, SkillLevel.beginner,
                      SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
        
        //从小到大排序后，再反转，得到从大到小的序列
        for level in levels.sorted().reversed() {
            print(level)
        }
    }
}

//MARK: - 协议类型的集合:
//在数组、字典、集合这样的数据集合内可以装入遵守同一协议的不同类型的数据：
func protocolCollectionUsage() -> Void {
    let nemi = Hamster.init(name: "Nemi")
    let d6 = Dice.init(sides: 6, generator: LinearCongruentialGenerator.init())
    let hamsters = [nemi, nemi, nemi]
    
    //在这里，装入things的数据的类型分别为：Hamster, Dice, Array.
    //因为它们都遵守TextRepresentable协议，所以这个操作并没有报错
    let things:[TextRepresentable] = [nemi, d6, hamsters]
    
    for thing in things {
        print(thing.textualDescription)
    }
}
//MARK: -协议的继承
//协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。
//协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔

//InheritingProtocol继承自Comparable、Hashable
protocol InheritingProtocol:Comparable, Hashable {
    
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextTualDescrion: String { get }
}
//MARK: - 类专属的协议:
//让协议继承自AnyObject，就可以限制协议只能被类类型采纳
protocol SomeClassProtocol: AnyObject {
    
}

//MARK: - 协议合成
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age:Int { get }
}

struct People:Named, Aged {
    var name: String
    var age: Int
    //这个方法要求传入一个遵循Named和Aged协议的类型
    func wishHappyBirthday(to celebrator: Named & Aged) {
        print("Happy birthday, \(celebrator.name), you are \(celebrator.age) !")
    }
    
    static func usage() {
        let Nemo = People.init(name: "Nemo", age: 23)
        Nemo.wishHappyBirthday(to: Nemo)
    }
}

//这个类用来表示位置
class Location {
    var latitude: Double
    var longitude:Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
//城市类继承自Location类，且遵守Named协议
class City: Location, Named {
    var name: String
    init(name:String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
    //这个方法要求一个(或自己)父类为Location，且遵守Named协议的类型
    func begainConcert(in location: Location&Named) {
        print("Hello, \(location.name):(\(location.latitude), \(location.longitude)")
    }
    
    static func usage() {
        let seattle = City.init(name: "Submarine", latitude: +118.6, longitude: +30.22)
        seattle.begainConcert(in: seattle);
        seattle.begainConcert(in: seattle)
    }
}
//MARK: - 检查协议一致性
protocol HasArea {
    var area:Double { get }
}

class Circle: HasArea {
    let PI = 3.1415927
    var radius: Double
    var area: Double {
        return PI * radius * radius
    }
    init(radius:Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    let name:String
    let area: Double
    init(name:String, area:Double) {
        self.name = name
        self.area = area
    }
}

class AnimalClass {
    let legs:Int
    init(legs:Int) {
        self.legs = legs
    }
}

func protocolCheckUsage() {
    let objectArr:[AnyObject] = [AnimalClass.init(legs: 4), Country.init(name: "English", area: 243_610), Circle.init(radius: 20)]
    for obj in objectArr {
        //将类型转为遵守HasArea的类型：
        //obj as? HasArea返回HasArea?类型，当obj不满足协议时返回空
        //obj as! HasArea返回HasArea类型，当obj不满足协议时崩溃
        if let objHasArea = obj as? HasArea {
            print("Area is \(objHasArea.area)")
        }else {
            print("obj has no area")
        }
        //判断是否遵守协议
        if obj is HasArea {
            print("AA YES")
        }
    }
}

//MARK: - 可选的协议要求
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement:Int { get }
}

class Counter1 {
    var count = 0
    //因为dataSource是可选的，所以调用dataSource涉及到可选链调用，其返回值也会是可选的
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        }else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

//MARK: - 协议扩展
//扩展了随机数协议，使得所有遵守这个协议的类无需任何额外修改，就可以获得randomBool方法
//协议扩展可以为遵循协议的类型增加实现，但不能声明该协议继承自另一个协议。协议的继承只能在协议声明处进行指定
extension RandomNumGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

//MARK: - 为协议提供默认实现
//可以通过协议扩展来为协议要求的方法、计算属性提供默认的实现。
//如果遵循协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
//PrettyTextRepresentable继承自TextRepresentable，
//可以为prettyTextTualDescrion提供一个返回textualDescription的默认实现
extension PrettyTextRepresentable {
    //prettyTextTualDescrion属性的默认实现：
    var prettyTextTualDescrion:String {
        return textualDescription
    }
}

//MARK: - 为协议扩展添加限制条件
//在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，
//才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，
//使用 where 子句来描述，正如 泛型 Where 子句 中所描述的。

//扩展 Collection 协议，适用于集合中的元素遵循了 Equatable 协议的情况:
extension Collection where Element: Equatable {
    func allEquals() -> Bool {
        let first = self.first
        for item in self {
            if item != first {
                return false
            }
        }
        return true
    }
    
    static func usage() {
        let arr1 = [100, 100, 100]
        let arr2 = [100, 200, 100]
        let arrs = [arr1, arr2]
        for arr in arrs {
            if arr.allEquals() {
                print("\(arr) is allEquals")
            }else {
                print("\(arr) is not allEquals")
            }
        }
    }
}


func protocolUsage() -> Void {
    protocolCheckUsage()
}
