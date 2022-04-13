//
//  FuncAndMethod.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation


//无参数、无返回值的函数
func f0() {
    //定义函数类型：
    //    var operation: (lhs: Int, rhs: Int) -> Int      // 错误
    //    var operation: (_ lhs: Int, _ rhs: Int) -> Int  // 正确
    //    var operation: (Int, Int) -> Int                // 正确
    //如果一个函数类型包涵多个箭头（->），那么函数类型将从右向左进行组合。
    //如，函数类型 (Int) -> (Int) -> Int，可以理解为 (Int) -> ((Int) -> Int)
    //该函数传入 Int，并返回另一个传入并返回 Int 的函数。
    var a = 9
    let _ = f11(numbers: 4,3,5)
    let _ = f11(numbers: 4.5, 3.1, 5.6)
    
    f1(va1: 2, va2: 3)
    print(f2(9, 9), f3(fir: 9)!, f4(fir: &a),f8(v: 99),f9())
    f5()
    f5(fir: 28)
    f7(f1: f2(_:_:), f2: f0)
    
}
func f00()->() {
}
//显式参数名、无返回值的函数
func f1(va1:Int, va2:Int) ->Void {
    let n = va1 + va2
    print("\(n)")
}
//隐式参数名、返回值为Int的函数
func f2(_ va1:Int, _ va2:Int) -> Int {
    let n = va1 + va2
    print("\(n)")
    return 3
}
//指定参数标签、返回值为可选String的函数
func f3(fir va1:Int) -> String? {
    
    let n = va1
    print("\(n)")
    return "vvv"
}
//指定参数标签、可改变传入值、隐式返回Int的函数
func f4(fir va: inout Int) ->Int {
    va
}
//指定参数标签、有默认参数值、无返回值的函数
func f5(fir va: Int = 77) {
    
}
//指定参数标签、参数个数可变、返回值为算术平均值的函数
func f6(fa nums:Double...) ->Double {
    var sum = 0.0
    
    for n in nums {
        sum += n
    }
    
    return sum / Double(nums.count)
}
//函数为参数的函数，参数1：参数为Int、Int，返回值为Int，参数2：无参数、返回值
func f7(f1: (Int, Int)->Int, f2: ()-> Void){
    print(f1(1,2))
    f2()
}
//参数为Int，返回值为(Int, Int)->Int型的函数的函数
func f8(v:Int) -> (Int, Int)->Int{
    f2
}

//以上8个都是全局函数
//没有参数，返回值为(Int)->Int的函数，该函数内部定义了一个函数（嵌套函数）
func f9()-> (Int)->Int {
    func fn(v:Int = 3) -> Int {
        3
    }
    print(fn(), fn(v: 88))
    return fn
}

//参数数量可变的函数，一个函数只能有一个可变参数
func f10 (numbers:Int...) -> Int {
    var sum = 0
    for num in numbers {
        sum += num
    }
    return sum
}
//范型+可变参数
func f11<T:AdditiveArithmetic>(numbers: T...) -> T{
    var sum:T = (0 as! T)
    for num in numbers {
        sum += num
    }
    return sum
}
//紧跟在可变参数后面的参数不能省略参数标签
func f12(nums:Int..., cnt:Int, _ xx:Int) -> Int {
    return 0
}

//inout修饰的参数不能有默认值
//可变参数不能修饰为inout

//内联函数inline：内联函数从源代码层看，有函数的结构，而在编译后，却不具备函数的性质。内联函数不是在调用时发生控制转移，而是在编译时将函数体嵌入在每一个调用处。编译时，类似宏替换，使用函数体替换调用处的函数名。一般在代码中用inline修饰，但是能否形成内联函数，需要看编译器对该函数定义的具体处理。内联扩展是用来消除函数调用时的时间开销。
//简单说，就是编译器会把函内的代码直接在函数调用处展开，避免了函数调用时额外开辟调用栈，以提高性能
//可以在Build Setting里面搜索optimize来改变编译优化的级别
//不会发生内联的情况：①函数体较长；②包含递归调用；③包含动态派发；


//永远不会被内联，即使开启了编译器优化
@inline(never) func f13() {}

//开启编译器优化后，即使代码很长，也会被内联(递归调用、动态派发的函数除外)
@inline(__always) func f14() -> Void {}

//MARK:- 方法，方法即是函数，只不过这个函数与某个类型相关联了。
//定义了一个计数器，内部有有3个实例方法
class Counter {
    var count = 0
    
    //计数加1方法
    func increment() {
        count += 1
        //方法(函数)的参数名如果和属性重名了，那么方法的参数名优先级更高，此时应用点语法去访问属性
        //self.count += 1
    }
    //计数加一定数量的方法
    func increment(by amount:Int) {
        count += amount
    }
    func inc(by amount:Int = 1) {
        count += amount
    }
    //重置方法
    func reset() {
        count = 0
    }
}

struct PointWithFunc {
    var x = 0.0, y = 0.0
    //默认情况下，值类型的属性不能在它的实例方法中被修改。使用关键字mutating就可以在实例方法内部改变值类型属性了
    mutating func moveBy(_ deltaX:Double, _ deltaY:Double ) {
        self.x += deltaX
        self.y += deltaY
    }
}

//枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员
//定义了一个三态切换的枚举。每次调用 next() 方法时，开关在不同的电源状态（off, low, high）之间循环切换.
enum TriStateSwitch {
    case off, low, hight
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .hight
        case .hight:
            self = .off
        }
    }
}

func methodUsage() {
    let cnt = Counter()
    cnt.increment()
    cnt.increment(by: 20)
    cnt.reset()
    
    //如果结构体、枚举实例是常量(let关键字定义),那么无法调用它的mutating方法
    var p = PointWithFunc()
    p.moveBy(20, 20)
    
    var tri = TriStateSwitch.off
    //每次调用 next() 方法时，开关在不同的电源状态（off, low, high）之间循环切换。
    tri.next()
    tri.next()
}

//类型方法用关键字static来声明类型方法(类似OC的类方法)
//在方法的 func 关键字之前加上关键字 static，来指定类型方法。类还可以用关键字 class 来指定，从而允许子类重写父类该方法的实现。
class SomeClassWithMethod {
    //无法被子类重写的类型方法
    static func six(six num:Int = 2) {
        print("SomeClassWithMethod - 6")
    }
    
    //可被子类重写的类型方法
    class func someMethod() {
        print("SomeClassWithMethod - someMethod")
    }
    //在类型方法中self指向类型，所以如果类型方法的参数和类型属性重名，可以用点语法访问类型属性
}


struct StaMetAndInsMet {
    var instanceProperty = 1
    static var staticProperty = 1
    
    func instanceMethod1(n:Int) {
        //在实例方法內可以像调用函数一样直接调用其他实例方法，也可以直接访问实例属性
        iM2(n: instanceProperty)
        //通过实例本身进行调用/访问：
        self.iM2(n: self.instanceProperty)
    }
    
    func iM2(n:Int) {
        
    }
    
    static func staticMetho1() {
        //在类型方法內可以像调用函数一样直接调用其他类型方法，也可以直接访问类型属性
        sM2(n: staticProperty)
        //通过类型的调用/访问：
        self.sM2(n: self.staticProperty)
    }
    
    static func sM2(n:Int) {
    }
    
    @discardableResult
    mutating func advance(to level:Int?) -> Bool? {
        if let _ = level {
            return true
        }else{
            return false
        }
    }
}
