//
//  EnumUsage.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation

//枚举遵守协议<CaseIterable>后会生成allCases属性,是个包含所有枚举情况的数组
enum CompassPoint :CaseIterable {
    case north, east
    case west, south
}

//关联值
//有时候把其他类型的值和成员值一起存储起来会很有用。这额外的信息称为关联值，
//并且你每次在代码中使用该枚举成员时，还可以修改这个关联值

//定义一个名为 Barcode 的枚举类型，它的一个成员值是具有 (Int，Int，Int，Int) 类
//型关联值的 upc，另一个成员值是具有 String 类型关联值的 qrCode。
//关联值是将传入的关联值，直接存进枚举变量的内存当中
//前n个字节存关联值(n取最大的关联值的空间大小)，在加m个字节标识到底是哪一个枚举成员，
//m取决于枚举成员的个数个数在1~256时大小是1B, 超过256就变成了2B
enum Barcode {
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}

//原始值
//作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，
//这些原始值的类型必须相同。
//有原始值的枚举占有的空间大小和枚举的成员个数有关，经过实验发现：个数在1~256时大小是1B, 超过256就变成了2B
//这是一个使用 ASCII 码作为原始值的枚举,原始值可以是字符串、字符，
//或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
enum ASCIICharacter: Character{
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//原始值的隐式赋值
//在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。枚举的隐式赋值，逐次加一，venus为2，jupiter为10，rawValue属性可以访问原始值
enum Planet:Int {
    case mercury = 1, venus, earth, mars = 9, jupiter, saturn, uranus, neptune
}

//隐式原始值：如果枚举的原始值是Int、String那么Swift会自动分配原始值
enum Abc:String {
    //此时有隐式原始值"A", "B", "C"
    case A, B, C
    //等价于：
    case D = "D"
    case E = "E"
    case F = "F"
    
    func usage() -> Void {
        let cc = Abc.A
        print(cc.rawValue)
    }
}

//递归枚举
//递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。
//使用递归枚举时，编译器会插入一个间接层。
//你可以在枚举成员前加上 indirect 来表示该成员可递归。
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
    
    //用递归的方式计算，递归枚举的值
    static func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }
}

//你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的：
indirect enum ArithExpres {
    case number(Int)
    case addition(ArithExpres, ArithExpres)
    case multiplication(ArithExpres, ArithExpres)
}


enum Date {
    case digit(year:Int, month:Int, day:Int)
    case str(String)
    
    static func usage() {
        var time = Date.digit(year: 2020, month: 06, day: 11)
        time = .str("2020-06-11")
        
        switch time {
        case let .digit(year: y, month: m, day: d):
            print(y, m, d)
        case .str(let s):
            print(s)
        }
    }
}



func enumUsage () {
    var e = CompassPoint.north
    
    //e的枚举类型已知时，可以省略赋值的类型
    if arc4random_uniform(2) == 0 {
        e = .west
    }else{
        e = .north
    }
    
    //在switch里面也可以省略类型
    switch e {
    case .north:
        print("N")
    case .east:
        print("E")
    case .west:
        print("W")
    case .south:
        print("S")
    }
    
    //枚举遵守协议<CaseIterable>后会生成allCases属性,是个包含所有枚举情况的数组
    print(CompassPoint.allCases.count)
    for p in CompassPoint.allCases {
        print(p)
    }
    
    
    
    var code:Barcode
    
    if arc4random_uniform(2)==0 {
        code = Barcode.upc(2, 3, 3, 3)
    }else{
        code = Barcode.qrCode("74390")
    }
    
    aswith: switch code {
    case .upc(0, let y, let z, _):
        print(0, y, z)
    case .qrCode(let str):
        print(str)
    default:
        break aswith
    }
    
    switch code {
    case let .upc(x, y, z, t):
        print(x,y,z,t)
    default:
        print("default")
    }
    
    print(Planet.earth.rawValue)
    
    //使用原始值初始化枚举实例
    //返回值是可选类型，原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员。更多信息请参见 可失败构造器。
    let _ = Planet(rawValue: 7)
    
    
    
    
    
}


