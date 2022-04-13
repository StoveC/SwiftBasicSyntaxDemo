//
//  ControlFlowAndLoop.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//控制流和循环

import Foundation

//if语句
func ifCode() {
    var str:String? = "sss"
    let str1:Optional<String> = nil
    
    if("sss"==str){
        print("sss" + "==" + "sss")
    }else{
        print("NOEqual")
    }
    
    
    //if语句的括号也可以省略掉
    str = nil
    if str==nil {
        print("str==nil")
    }else{
        print("str!=nil")
    }
    
    //可选类型绑定
    if let s = str, let ss = str1
    {
        print(s, ss)
    }else{
        print("没有值")
    }
    
    //隐式展开,前提是a有值，否则崩溃：
    var a:Int! = 100
    
    a = nil
    
    a = 3
    
    
    let b:Int = a
    
    print(b)
    
}
//guard语句，用来断定必须满足的条件
func guardUsage () {
    let a = 33, b = 11
    
    //如果条件不为真，则执行括号内的代码，括号内的代码必须以 return 或 throw 语句结尾，
    //条件为真，则执行整个guard语句后的代码
    //使用场景，用来确定一些必定要满足的条件
    /*
     guard 必定要满是的条件 else {
         在此做一些条件无法满足的情况下的处理，
         return获赞throw
     }
     */
    guard a < b else {
        print("\(a) < \(b)")
        return
    }
    
}

//switch
func switchTest() {
    //Swift的switch默认没有穿透效果，如果需要穿透，可以使用fallthrough
    //switch的case以及default后面至少要有一条语句，如果并不想执行任何操作，那么加一个break就好
    var a:Int
    a = Int(arc4random_uniform(100))
    
    switch a {
    case 1:
        print("1")
    case 2:
        print("2")
    //可以匹配多个数值：
    case 3, 4, 5:
        print("3或4或5")
    case 6:
        print(6)
        fallthrough
    case 7:
        print("7或6")
    //也可以用区间运算符去匹配多个值
    case 8..<12:
        print("[8, 11]")
    case 12..<33:
        print("[12, 32]")
    case 33...55:
        print("[33, 55]")
    default:
        print("无")
    }
    
    let tup = (arc4random_uniform(10),arc4random_uniform(10))
    
    //用switch对元组拆分匹配赋值
    switch tup {
        case let(n1, 0):
            print("n1 =",n1,",n2 = 0")
        case let(n1, n2) where n1 > n2:
            print("n1 =",n1,",n2 =",n2)
        case (_, _):
            print("")
    }
    
    let somePoint = (arc4random_uniform(10), arc4random_uniform(10))
    
    switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (1... , 1...):
            print("area 1")
        default:
            break
    }
    
    //值绑定
    switch somePoint {
        case (0, let y):
            print("0-\(y)")
            
        case (let x, 0):
            print("\(x)-0")
            
        case (let x, let y):
            print("\(x)-\(y)")
    }
    
    
}


//区间运算符
func range() {
    /*
     [2, 8]
     [-7, 6)
     [3.9, 10]
     [1.77, +∞)
     (-∞, 6]
     (-∞, 11)
     
     */
    //可以显示指明range类型，以及range的是Int还是Double
    let _:Range = 1..<3
    let _:Range<Int> = 1..<3
    let _:Range<Double> = 1..<3
    let _:Range<Character> = "a"..<"z"
    let _:Range<String> = "cc"..<"ee" //cc, cd...cz, da, db...dz, ea, eb, ec, ed
    
    
    let _:Range = 1..<3
    let _:ClosedRange = 1...3
    let _:PartialRangeThrough = ...4
    let _:PartialRangeFrom = 1...
    let _:PartialRangeUpTo = ..<2
    
    
    
    var r1 = 1...3
    var r2 = -7..<8
    var r3 = (3.14)...4
    //r4表示1.5～无限大
    let r4 = 1.5...
    //r5表示无穷小到33
    let r5 = ..<33
    
    r1 = 2...7
    r2 = -20..<33
    r3 = (-1.101)...5.3
    
    print("r1范围\(r1),r2范围\(r2),r3范围\(r3),r4范围\(r4)，r5范围：\(r5)")
    
    if r1.contains(3) {
        print("r1 contains 3!")
    }
    
    let names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", ]
    
    for name in names[2...] {
        print(name)
    }
    print("\n")
    
    for name in names[...2] {
        print(name)
    }
    print("\n")
    
    for name in names[..<4] {
        print(name)
    }
}

func loop() {
//    for i in 0...9 {
//        print(i)
//    }
    
    //i属于[0，10)，每轮循环结束i+=2
//    for i in stride(from: 0, to: 10, by: 2) {
//        print(i)
//    }
    
    //i属于[0，10]，每轮循环结束i+=2
//    for i in stride(from: 0, through: 10, by: 2) {
//        print(i)
//    }
    
    //反向：
//    for i in stride(from: 0, to: 15, by: 2).reversed() {
//        print(i)
//    }
   
    //swift可以为循环指定标签，在使用控制流语句break、continue时指定操作的循环
    loop: for i in (1...100).reversed().reversed() {
        if i%3==0 {
            continue loop
        }
        print(i)
        if i==50 {
            break
        }
    }
    /*
     这种C风格的for循环，在swift3被移除了
    for var i=0; i <10; i+=1 {
        print(i)
    }
     */
    
   
    var i = 0
    repeat{
        print(i)
        i += 1
    }while i < 6
    
    i = 0
    while i < 6 {
        print(i)
        i += 1
    }
    
    for i in stride(from: 0, to: 60, by: 2) {
        print(i)
    }
    //上面的for-in等价于下面的C语言循环：
    /**
     for(int i = 0;  i < 60; i += 5){
        printf("%d\n",i);
     }
     */
    
    for i in stride(from: 0, through: 60, by: 5) {
        print(i)
    }
    //上面的for-in等价于下面的C语言循环：
    /**
     for(int i = 0;  i <= 60; i += 5){
        printf("%d\n",i);
     }
     */
    
    let names = ["Jack", "Nemo", "Deffu", "Lina", "Wang", "Hariey"];
    for name in names[1...3] {
        print(name)
    }
    
    for name in names[2...] {
        print(name)
    }
    
    for name in names[...3] {
        print(name)
    }
    for name in names[..<3] {
        print(name)
    }
    for _ in 1...3 {
        print("Hey!")
    }
    
    for var i in 0...5 {
        i+=1
        print("Hey\(i)")
    }
    
    for i in -10...10 where i>0 {
        print(i);
    }
}
