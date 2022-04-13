//
//  Inherit.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation

//MARK:-继承
//不继承于其它类的类，称之为基类。
//Swift 中的类并不是从一个通用的基类继承而来的。如果你不为自己定义的类指定一个超类的话，这个类就会自动成为基类。
class Vehicle {
    var currentSpeed = 0.0
    
    var discription:String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        //什么也不做，留给子类继承重写
    }
    
}
//继承自父类Vehiclc
class Bicycle: Vehicle {
    var hasBasket = false
    
    class func usage() {
        let b = Bicycle()
        b.hasBasket = true
        b.currentSpeed = 30
        print(b.discription)
    }
}

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
    override class func usage() {
        let t = Tandem()
        t.currentSpeed = 100
        t.currentNumberOfPassengers = 3
        t.hasBasket = true
        print(t.discription)
    }
}
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Chio")
    }
    class func usage() {
        let t = Train()
        t.makeNoise()
    }
}

class Car: Vehicle {
    var gear = 1
    override var discription: String {
        return super.discription + "in gear \(gear)"
    }
}

class AutomaticCar: Car {
    override var currentSpeed: Double {
        set {
            super.currentSpeed = newValue
        }
        get {
            super.currentSpeed
        }
        
//        didSet {
//
//        }
//
//        willSet {
//
//        }
    }
}
//不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供 willSet 或 didSet 实现也是不恰当。 此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
class C1 {
    let one = 1
    var two = 2
    var three = 3 {
        willSet {
            
        }
        
        didSet {
            
        }
    }
    var _four = 4
    
    var four:Int {
        get {
            _four
        }
        
        set {
            
        }
    }
    
    var five:Int {
        return 5
    }
    
    subscript(i:Int) ->Int {
        return i
    }
    
    static subscript(i:Int) ->Int {
        get {
            return i
        }
    }
}
//常量存储属性无法重载
//重载属性时，get/set 无法和 willSet/didSet 同时重载
//只读计算属性可以被重载为读写计算属性,重载时不能为只读计算型属性添加属性观察器
//读写计算属性不被重载为只读计算属性
//变量存储属性可以被重载为计算存储属性
//用final修饰的属性、方法、下标无法重载，类方法/属性/下标中计即使是用class修饰的也无法重载
//定义类时可以载class前用final关键字，使该类无法被继承
/*
 你可以通过把方法，属性或下标标记为 final 来防止它们被重写，只需要在声明关键字前加上 final 修饰符即可（例如：final var、final func、final class func 以及 final subscript）。

 任何试图对带有 final 标记的方法、属性或下标进行重写的代码，都会在编译时会报错。在类扩展中的方法，属性或下标也可以在扩展的定义里标记为 final。

 可以通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
 */
class C2: C1 {
    override var two: Int {
//        set {
//            super.two = newValue
//        }
//        get {
//            return super.two
//        }
        
        willSet {
            
        }
        didSet {
            
        }
    }
    
    override var five: Int {
        set {
            
        }
        get {
            5
        }
    }
    
    override var four: Int {
        get {
            3
        }
        set {
            
        }
    }
    
    override var three: Int {
        willSet {}
        didSet {}
    }
    
    
}
