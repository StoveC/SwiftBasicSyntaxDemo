//
//  InitAndDeinit.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation


//MARK:-构造过程
//类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
//当你为存储型属性分配默认值或者在构造器中为设置初始值时，它们的值是被直接设置的，不会触发任何属性观察者。
//只读属性可以在定义时初始化，也可以在构造器内初始化,如果定义时已经初始化，那么构造器内不能再次初始化，构造器内也只能初始化一次，既只读类型无论如何都只能初始化一次
//构造器可以像函数那样设置成标签、不提供标签、隐藏标签的定义
//可选类型属性会自动赋值为nil（nil不是代表值为nil，而是代表没有值的状态）
//默认构造器：如果<结构体或类>内部的属性在定义时都默认提供了一个初始值，那么它就具有一个默认构造器init()
//逐一成员构造器：如果<结构体>没有定义任何自定义构造器，它们将自动获得一个逐一成员构造器（memberwise initializer）。该构造器可以省略任何一个有默认值的属性
//在
/*
 如果一个属性总是使用相同的初始值，那么为其设置一个默认值比每次都在构造器中赋值要好。两种方法的最终结果是一样的，只不过使用默认值让属性的初始化和声明结合得更紧密。它能让你的构造器更简洁、更清晰，且能通过默认值自动推导出属性的类型；同时，它也能让你充分利用默认构造器、构造器继承等特性
 */
/*
 如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这种限制避免了在一个更复杂的构造器中做了额外的重要设置，但有人不小心使用自动生成的构造器而导致错误的情况。
 */
struct Celsius {
    var temperatureInCelsius:Double
    
    init(fromFahrenheit fahrenheit:Double) {
        temperatureInCelsius = (fahrenheit-32.0)/1.8
    }
    
    init(fromKelvin kelvin:Double ) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    static func usage() {
        let t1 = Celsius(fromKelvin: 300)
        let t2 = Celsius.init(fromFahrenheit: 100)
        print(t1,t2)
    }
}

struct Color {
    let red, green, blue:Double
    private var alpha:Double = 1
//    init(red:Double, green:Double, blue:Double) {
//        self.red = red
//        self.green = green
//        self.blue = blue
//    }
//
//    init(white:Double) {
//        red = white
//        green = white
//        blue = white
//    }
    func usage() {
        //结构体的逐一成员构造器，alpha有默认值1，可以省略参数alpha：
//        let _ = Color.init(red: 0.1, green: 0.6, blue: 0.2)
        let _ = Color.init(red: 0.1, green: 0.6, blue: 0.2, alpha: 0.5)
    }
}

struct SurveyQuestion {
    var text:String
    var response:String?
    init(text:String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}
//<值类型>的构造器代理
//构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能避免多个构造器间的代码重复
//假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中
struct RectWithInit {
    var origin = Point()
    var size = Size()
    
    init() {}
    
    init(origin:Point, size:Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center:Point, size:Size) {
        self.init(origin: Point(x: center.x-size.width/2.0, y: center.y-size.height/2.0), size: size)
    }
}

class F {
    var f = 9
    
    init(f:Int) {
        self.f = f
    }
    init(f2:Int) {
        self.f = f2
    }
    
    convenience init(ff:Int) {
        self.init(f: 10)
        f = ff
    }
    
    class func usage() {
        let _ = F.init(ff: 2)
    }
}

class Cl: F {
    var cl:Int
    
    init(cl:Int) {
        self.cl = cl
        super.init(f: 2)
    }
    
    convenience init(ff: Int) {
        self.init(cl: 2)
    }
    
    convenience init(cll:Int) {
        self.init(cl:2)
        
        self.cl = 1
        self.cl = 2
        self.cl = 3
        self.cl = 4
        self.cl += cll
    }
}

//值类型：
//值类型具有默认构造器(当所有属性都有默认初始值时)、逐一成员构造器(对于已有初始值的属性可以省略参数，如果有私有属性在类外部时逐一成员构造器失效，感觉默认构造器可以理解为逐一成员构造器的一种)
//当值类型提供了自定义构造器后默认构造器以及逐一成员构造器都会失效

//类类型：
//当所有属性都具有默认值时，类类型才有默认构造器，类类型不具有逐一成员构造器
//当有自定义构造器时默认构造器会失效
//类至少具有一个指定构造器(一般情况下也只定义一个)

//便利构造器必须先调用自己的指定构造器(可以调用多次)后，才能对属性进行进一步的自定义初始化
//指定构造器必须在完成自己的非继承所得属性的初始化后，再调用父类的指定构造器(只能调用一次)，才能对属性进行进一步的自定义初始化

//对于类初始化的两个阶段的具体说明：
//阶段一指的是从子类开始沿(子类便利构造器)->子类指定构造器(完成非继承类的初始化)->父类指定构造器(完成父类的非继承类的初始化)...->基类指定构造器(完成基类的非继承类的初始化)，到达基类的属性初始化
//第二阶段是指从基类开始沿 基类指定构造器(完成基类的属性自定义)->...父类指定构造器(完成父类的内的属性自定义)..->子类指定构造器(完成父类的内的属性自定义)->(子类便利构造器,完成属性自定义)，到达子类的各级属性自定义
/*
 Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程不出错地完成：

 安全检查 1
     指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。

 如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类的属性在它往上代理之前先完成初始化。

 安全检查 2
     指定构造器必须在为继承的属性设置新值之前向上代理调用父类构造器。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。

 安全检查 3
     便利构造器必须为任意属性（包括所有同类中定义的）赋新值之前代理调用其它构造器。如果没这么做，便利构造器赋予的新值将被该类的指定构造器所覆盖。

 安全检查 4
     构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用 self 作为一个值。
 
 类的实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成后，类的实例才是有效的，才能访问属性和调用方法。

 以下是基于上述安全检查的两段式构造过程展示：

 阶段 1
 类的某个指定构造器或便利构造器被调用。
 完成类的新实例内存的分配，但此时内存还没有被初始化。
 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
 指定构造器切换到父类的构造器，对其存储属性完成相同的任务。
 这个过程沿着类的继承链一直往上执行，直到到达继承链的最顶部。
 当到达了继承链最顶部，而且继承链的最后一个类已确保所有的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
 阶段 2
 从继承链顶部往下，继承链中每个类的指定构造器都有机会进一步自定义实例。构造器此时可以访问 self、修改它的属性并调用实例方法等等。
 最终，继承链中任意的便利构造器有机会自定义实例和使用 self。
 */

//构造器重载：
//只要是是重载父类的指定构造器(无论是重载为指定还是便利构造器)，都需要用override关键字
//不管重载父类的便利构造器为何种构造器，都不需要override关键字


//类的构造器分为两种：指定构造器、便利构造器(定义时前面加convenience关键字)
//一般情况下类类型的构造器无法被继承，满足以下两种情况时可以被继承：
//1.子类没有定义任何的指定构造器时，那么子类会继承父类的全部指定构造器
//2.如果子类提供类父类全部构造器的实现(通过规则1继承，或者重载，重载为便利构造器也可以)，那么子类会继承父类的全部便利构造器


class VehicleWithInit {
    var numberOfWheels = 0
    
    var discription:String {
        return "\(numberOfWheels) wheel(s)"
    }
    //此时该类具有一个默认构造器(默认构造器总是指定构造器)
}

class Hoverboard: VehicleWithInit {
    var color: String
    init(color:String) {
        self.color = color
        //如果父类有一个无参数的指定构造器，且在子类构造器在第二阶段没有自定义操作，那么在所有子类的存储属性赋值之后可以省略super.init 的调用
        //这里隐式调用了 super.init()
    }
    
}

//可失败构造器
//1.可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
//2.可失败构造器会创建一个类型为自身类型的可选类型的对象。你通过 return nil 语句来表明可失败构造器在何种情况下应该 “失败”。
//严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用 return nil 表明可失败构造器构造失败，而不要用关键字 return 来表明构造成功。

//下面这个类定义了可失败构造器，当传入的字符串长度为0时构造失败
struct Animal {
    let species:String
    init?(species:String) {
        if species.isEmpty {
            return nil
        }
        //如果return nil，那么下面的语句是不会被执行的
        self.species = species
    }
    
    static func usage() {
        if let a = Animal(species: "") {
            print(a)
        }
        
        if let a = Animal.init(species: "bird") {
            print(a)
        }
    }
}
//枚举类型的可失败构造器：
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol:Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
    
    static func usage() {
        let e = TemperatureUnit.init(symbol: "K")
        
        if e != nil {
            print(e!)
        }else {
            print("构造失败")
        }
        
    }
}
//带原始值的枚举类型会自带一个可失败构造器 init?(rawValue:)，该可失败构造器有一个合适的原始值类型的 rawValue 形参，选择找到的相匹配的枚举成员，找不到则构造失败。
enum TemperatureUnit_new:Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
    
    static func usage() {
        if let e = TemperatureUnit_new.init(rawValue: "F") {
            print(e)
        }else {
            print("构造失败")
        }
    }
}

//构造失败的传递
/*
 类、结构体、枚举的可失败构造器可以横向代理到它们自己其他的可失败构造器。类似的，子类的可失败构造器也能向上代理到父类的可失败构造器。

 无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止，接下来的任何构造代码不会再被执行。
 */

class Product {
    let name:String
    
    init?(name:String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CarItem: Product {
    var quantity:Int
    
    init?(name: String, quantity:Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        //构造失败的传递
        super.init(name: name)
    }
}

//重写一个可失败构造器
//可以把可失败构造器重写为不可失败构造器，但是不能把不可失败构造器重写为可失败构造器
class Document {
    var name:String?
    
    //该构造器构造了一个name属性没有值的 document 实例
    init() {}
    
    // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
    init?(name:String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        }else {
            self.name = name
        }
        //下面这种写法也可以，在子类的不可失败构造器中使用强制解包来调用父类的可失败构造器
//        if name.isEmpty {
//            super.init(name: "[Untitled]")!
//        }else {
//            super.init(name: name)!
//        }
    }
}
//可以在init?中代理到(调用)init!，反之亦然。也可以把init?重载为init!，反之亦然。还可以在init中调用init!，不过，一旦 init! 构造失败，则会触发一个断言。

//必要构造器：
//在类的构造器前添加 required 修饰符表明所有该类的所有子类都必须实现该构造器：
//在重写父类中必要的指定构造器时，不需要添加 override 修饰符：
class ClassWithRequireInit {
    required init(a:Int) {
        // 构造器的实现代码
    }
}

class Subclass: ClassWithRequireInit {
    required init(a: Int) {
        super.init(a: 2)
    }
    
    static func usage()  {
        let _ = Subclass.init(a: 1)
    }
}
//通过闭包或函数设置属性的默认值:
//注意闭包结尾的花括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
//如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的 self 属性，或者调用任何实例方法。
struct ChessBoard {
    var boardColors:[Bool] = {
       var tempBoard = [Bool]()
        var isBlack = false
        for i in 0...7 {
            for j in 0...7 {
                tempBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return tempBoard
    }()
    
    /// 用来判断棋盘上某一位置的方块是否是黑色的
    /// - Parameters:
    ///   - row: 行，从0开始
    ///   - column: 列从0开始
    /// - Returns: 返回布尔值，true为黑
    func squareIsBlackAt(row:Int, column:Int) -> Bool {
        assert(0<row&&row<8 && 0<column&&column<8, "Index out of range")
        return boardColors[row*8 + column]
    }
    
    static func usage() {
        let aChessBoard = ChessBoard()
        print(aChessBoard.squareIsBlackAt(row: 2, column: 3))
    }
}



//MARK: - 析构过程
//析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字 deinit 来标示，类似于构造器要用 init 来标示。
//析构器是在实例释放发生前被自动调用的,直到实例的析构器被调用后，实例才会被释放。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
class Bank {
    static var coinsIntBank = 10_000
    
    static func distribute(coins numOfCoinsRequest:Int) ->Int {
        let num = min(numOfCoinsRequest, coinsIntBank)
        coinsIntBank -= num
        return num
    }
    
    static func receive(coins num:Int) {
        coinsIntBank += num
    }
}

class Player {
    var totalCoins:Int
    
    init(coins num:Int) {
        totalCoins = Bank.distribute(coins: num)
    }
    
    func win(coins num:Int) {
        totalCoins += Bank.distribute(coins: num)
    }
    deinit {
        Bank.receive(coins: totalCoins)
    }
    
    static func usage() {
        var playerOne:Player? = Player.init(coins: 100)
        print("A new player has joined the game with \(playerOne!.totalCoins) coins")
        
        print("There are now \(Bank.coinsIntBank) coins left in the bank")
        
        playerOne = nil
        print("PlayerOne has left the game")
        print("There are now \(Bank.coinsIntBank) coins in the bank")
    }
}
