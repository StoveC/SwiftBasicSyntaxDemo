//
//  GenericsUsage.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/8.
//范性

import Foundation
//介绍：
/*
 泛型代码让你能根据自定义的需求，编写出适用于任意类型的、灵活可复用的函数及类型。你可避免编写重复的代码，而是用一种清晰抽象的方式来表达代码的意图。
 泛型是 Swift 最强大的特性之一，很多 Swift 标准库是基于泛型代码构建的。实际上，即使你没有意识到，你也一直在语言指南中使用泛型。例如，Swift 的 Array 和 Dictionary 都是泛型集合。你可以创建一个 Int 类型数组，也可创建一个 String 类型数组，甚至可以是任意其他 Swift 类型的数组。同样，你也可以创建一个存储任意指定类型的字典，并对该类型没有限制。
 */

//MARK: - 泛型函数
//非范型实现两个Int的交换
func swapTwoInts(_ num1: inout Int , _ num2: inout Int) {
    let tmp = num1
    num1 = num2
    num2 = tmp
}
//非范型实现两个Double的交换
func swapDouble(_ num1: inout Double, _ num2: inout Double) {
    (num1, num2) = (num2, num1)
}
//swapTwoInts的局限：只能实现特定类型数据的交换

//swapTwoInts升级版：
//这里T的作用是要求value1和value2的类型一样，而不关心它们具体是什么类型
//注：交换函数在Swift标准库中已经存在：swap(T, T)
func swapTwoValues <T>(_ value1: inout T, _ value2: inout T) {
    let tmp = value1
    value1 = value2
    value2 = tmp
}

func mixUsage() {
    var num1 = 23
    var num2 = 99
    swapTwoInts(&num1, &num2)
    print("111num1 = \(num1), num2 = \(num2)")
    
    var str1 = "kkkkk"
    var str2 = "iiiii"
    swapTwoValues(&str1, &str2)
    print("222str1 = \(str1), str2 = \(str2)")
    
    swapTwoValues(&num1, &num2)
    print("333num1 = \(num1), num2 = \(num2)")
}

class Mixer {
    //方法作用：计算两个数组的笛卡尔积，这里使用了两个范型
    func mix<T1, T2>(_ arr1:[T1], _ arr2:[T2]) -> [(T1, T2)] {
        var result:[(T1, T2)] = []
        for item1 in arr1 {
            for item2 in arr2 {
                result.append((item1, item2))
            }
        }
        return result
    }
    
    func usage() {
        let mixMachine = Mixer.init()
        let arr1 = [1, 3, 5, 7, 9]
        let arr2 = ["a", "b", "c", "d"]
        let mixArr = mixMachine.mix(arr1, arr2)
        print("the mix result = \(mixArr)")
    }
}

//Int型的栈：
struct IntStack {
    private var stack:[Int] = []
    //压栈
    mutating func push(item:Int) {
        stack.append(item)
    }
    //出栈
    mutating func pop() -> Int {
        stack.removeLast()
    }
}

//范型版本的栈：
struct GenericsStack<GSElementType> {
    private var stack:[GSElementType] = []
    mutating func push(item:GSElementType) {
        stack.append(item)
    }
    
    mutating func pop() -> GSElementType {
        stack.removeLast()
    }
}

func stackUsage() {
    var intergerStack = IntStack.init()
    let intArr = [23, 99, 45, 18, 76, 100]
    for interger in intArr {
        intergerStack.push(item: interger)
    }
    for _ in intArr {
        print(intergerStack.pop(), separator: " ", terminator: "")
    }
    print("\n")
    
    
    //范型栈的使用，初始化时必须指明类型
    var strStack = GenericsStack<String>.init()
    let strArr = ["kkk", "iii", "jjj", "hhh", "uuu"]
    for str in strArr {
        strStack.push(item: str)
    }
    
    for _ in strArr {
        print(strStack.pop(), separator: " ", terminator: "")
    }
    print("\n")
}

extension GenericsStack {
    //返回栈顶元素，也就是数组的最后一个元素
    var topElement:GSElementType? {
        return stack.last
    }
    
}
//MARK: - 类型约束语法
//在数组内查找某个值对应的下标
func findIndex(ofString valueToFind:String, in arr:[String]) -> Int? {
    for (index, value) in arr.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
//查找下标函数的范型版本
func findIndex<T:Equatable>(of valueTofind:T, in arr:[T]) ->Int? {
    for (index, value) in arr.enumerated() {
        if valueTofind == value {
            return index
        }
    }
    return nil
}
//MARK: - 关联类型
//定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用。
//关联类型为协议中的某个类型提供了一个占位符名称，其代表的实际类型在协议被遵循时才会被指定。
//关联类型通过 associatedtype 关键字来指定。
protocol Container {
    associatedtype CElementType
    mutating func append(_ item:CElementType)
    var count:Int { get }
    subscript(i:Int) -> CElementType { get }
}

extension IntStack: Container {
    //Container协议中有一个关联类型，所以这里需要指明这个类型，
    //但是，如果实现了其他协议中有使用到关联类型的方法、属性，那么不需要显示得指明关联的类型具体是谁也可以
//    typealias CElementType = Int
    mutating func append(_ item: Int) {
        push(item: item)
    }
    
    var count: Int {
        return stack.count
    }
    
    subscript(i: Int) -> Int {
        return stack[i]
    }
}
//MARK: - 扩展现有类型来指定关联类型
//扩展后，可以把Array作为Container使用
extension Array:Container {}

//MARK: - 给关联类型添加约束
//这里限制关联类型为遵守Equatable的类型
protocol ContainerOfEquatableType {
    associatedtype T: Equatable
    mutating func append(_ item:T)
    var count:Int { get }
    subscript(i:Int) ->T { get }
}
extension GenericsStack: Container {
    mutating func append(_ item: GSElementType) {
        stack.append(item)
    }
    var count: Int {
        return stack.count
    }
    subscript(i: Int) -> GSElementType {
        return stack[i]
    }
}

protocol SuffixableContainer:Container {
    //这里要求的意思是suffix返回值的类型和 Container中储存的类型要一致
    associatedtype Suffix: SuffixableContainer where Suffix.CElementType == CElementType
    func suffix(_ size:Int) -> Suffix
}

extension GenericsStack: SuffixableContainer {
    func suffix(_ size: Int) -> GenericsStack {
        var result = GenericsStack.init(stack: [])
        for i in count-size..<count {
            result.append(stack[i])
        }
        return result
    }
}

//这里IntStack的关联类型是Int，GenericsStack也是Int（CElementType == IntStack.CElementType）
extension IntStack: SuffixableContainer {
    //如果把suffix()的返回类型改为其他类型，就会报错
    func suffix(_ size: Int) -> GenericsStack<Int> {
        var result = GenericsStack<Int>.init()
        for i in count-size..<count {
            result.append(self[i])
        }
        return result
    }
}
//检测两个容器的内容是否完全相同，要求两个容器内部元素的类型相同，且都遵守Equatable
func allCElementTypeMatch<C1:Container, C2:Container>(_ con1:C1, _ con2:C2) -> Bool where C1.CElementType==C2.CElementType, C1.CElementType:Equatable {
    guard con1.count == con2.count else {
        return false
    }
    
    for i in 0..<con1.count {
        if con1[i] != con2[i] {
            return false
        }
    }
    return true
}
//MARK: - 具有泛型 Where 子句的扩展

//一个不遵守Equatable协议的结构体
struct NotEquatableValue{}

extension GenericsStack where GSElementType:Equatable {
    //判断item是不是栈顶元素(数组的最后一个元素)
    func isTop(_ item:GSElementType) -> Bool {
        guard let topCElementType = stack.last else {
            return false
        }
        return topCElementType == item
    }
    
    func usage() -> Void {
        //当GenericsStack的GSElementType不遵守Equatable协议时调用isTop方法会在编译时报错
        var noteEqua = GenericsStack<NotEquatableValue>.init()
        noteEqua.push(item: NotEquatableValue.init())
//        noteEqua.isTop(2)  //Error
    }
}

//扩展协议，前提是关联类型CElementType遵循Equatable协议
extension Container where CElementType:Equatable {
    //判断容器是否是以item开头
    func isStartsWith(_ item:CElementType) -> Bool {
        return count > 0 && self[0] == item
    }
}
//扩展协议，前提是关联类型CElementType为Double
extension Container where CElementType==Double {
    //计算容器内元素的平均值
    func average() -> Double {
        var result = 0.0
        for i in 0..<count {
            result += self[i]
        }
        return result/Double(count)
    }
}
//MARK: - 包含上下文关系的 where 分句
//更加灵活，可以为单独的函数限定范型条件
extension Container {
    func average() -> Double where CElementType==Int {
        var result = 0
        for i in 0..<count {
            result += self[i]
        }
        return Double(result) / Double.init(result)
    }
    
    func isEndsWith(_ item:CElementType) -> Bool where CElementType:Comparable {
        return count > 0 && self[count-1]==item
    }
}

protocol Container1 {
    associatedtype CElementType
    mutating func append(_ item:CElementType)
    var count:Int { get }
    subscript(i: Int) -> CElementType { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == CElementType
    func makeIterator() -> Iterator
}

//struct Zxcv: Container1 {
//    typealias Iterator = [Int]
//
//    typealias CElementType = Int
//
//    private var stack = [Int].init()
//    mutating func append(_ item: Int) {
//        stack.append(item)
//    }
//
//    var count: Int {
//        return stack.count
//    }
//
//    subscript(i: Int) -> Int {
//        return stack.count
//    }
//
//    func makeIterator() -> some IteratorProtocol {
//        return self
//    }
//}
protocol Con:Container { }
extension Con {
    subscript<Indices: Sequence>(indices: Indices) -> [CElementType]
    where Indices.Iterator.Element == Int {
        var result = [CElementType]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

//MARK: - 具有泛型 Where 子句的关联类型
func GenericsUsage() {
    let num:Int8 = -0b000_100_0
    //1_111_100_0
    print(num)
        //-2
    //100_000_10
    print(num >> 2)
    print(num << 2)
    
    
//    print(num >> 2)
//    print(num >> 2)
}
