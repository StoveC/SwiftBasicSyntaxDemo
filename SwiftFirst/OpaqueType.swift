//
//  OpaqueType.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/9.
//

import Foundation

/*
 具有不透明返回类型的函数或方法会隐藏返回值的类型信息。函数不再提供具体的类型作为返回类型，
 而是根据它支持的协议来描述返回值。在处理模块和调用代码之间的关系时，
 隐藏类型信息非常有用，因为返回的底层数据类型仍然可以保持私有。
 而且不同于返回协议类型，不透明类型能保证类型一致性 —— 编译器能获取到类型信息，同时模块使用者却不能获取到
*/

//MARK: - 不透明类型解决的问题
//规定了遵守该协议的类都得有打印形状的方法
protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    //返回一个三角形的字符
    func draw() -> String {
        var result = String.init()
        var line = "*"
        for _ in 1..<size {
            result.append(line + "\n")
            line.append("*")
        }
        result.append(line)
        return result
    }
    func draw1() -> String {
        var strArr = [String].init()
        for length in 1...size {
            strArr.append(String.init(repeating: "*", count: length))
        }
        return strArr.joined(separator: "\n")
    }
    
    static func usage() {
        let tri3 = Triangle.init(size: 3)
        print(tri3.draw())
    }
}
//范型实现可以形状翻转的类
struct FlippedShape<T:Shape>:Shape {
    var graph:T
    func draw() -> String {
        if graph is Square {
            return graph.draw()
        }
        let lines = graph.draw().split(separator: "\n")
        //joined是字符数组转字符串的方法
        return lines.reversed().joined(separator: "\n")
    }
}



//这个结构代表两个图形拼接后的图形
struct JoinedShape<T1:Shape, T2:Shape>:Shape {
    let top:T1
    let bottom:T2
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
    
    static func usage() -> Void {
        let tri3 = Triangle.init(size: 3)
        let diamond = JoinedShape<Triangle, FlippedShape>.init(top:tri3 , bottom: FlippedShape.init(graph: tri3))
        print(diamond.draw())
    }
}
//MARK: - 返回不透明类型

//正方形图形
struct Square:Shape {
    var size:Int
    func draw() -> String {
        let line = String.init(repeating: "*", count: size)
        return String.init(repeating: line, count: size)
    }
}
//不透明类型的使用场景是：隐藏返回值的具体类型
//这里的返回值是一个不透明类型，隐藏了返回值的具体类型是JoinedShape
//这里函数的调用者只知道返回值遵守Shape，而不知道具体是什么类型
//但是这里编译器知道返回值具是什么类型
func makeTrapezoid() -> some Shape {
    let top = Triangle.init(size: 2)
    let middle = Square.init(size: 2)
    let bottom = FlippedShape.init(graph: top)
    return JoinedShape.init(top: top, bottom: JoinedShape.init(top: middle, bottom: bottom))
}

//将不透明返回类型和泛型结合起来
func flip<T:Shape>(_ graph:T) -> some Shape {
    return FlippedShape.init(graph: graph)
}

func join<T1:Shape, T2:Shape>(_ graph1:T1, _ graph2:T2) -> some Shape {
    return JoinedShape.init(top: graph1, bottom: graph2)
}

//如果函数中有多个地方返回了不透明类型，那么这些返回类型都应该是同一种类型，否则报错
//func invalidFlip<T:Shape>(_ graph:T) -> some Shape {
//    if graph is Square {
//        return graph
//    }
//    return FlippedShape.init(graph: graph)
//}

func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
    return Array<T>(repeating: shape, count: count)
}

//MARK: - 不透明类型和协议类型的区别
//两者有一个主要区别，就在于是否需要保证类型一致性。
//一个不透明类型只能对应一个具体的类型，即便函数调用者并不能知道是哪一种类型；
//协议类型可以同时对应多个类型，只要它们都遵循同一协议。
//总的来说，协议类型更具灵活性，底层类型可以存储更多样的值，而不透明类型对这些底层类型有更强的限定。
//返回类型的不确定性，意味着很多依赖返回类型信息的操作也无法执行了。
func protocolFlip<T:Shape>(_ graph:T) -> Shape {
    if graph is Square {
        return graph
    }
    return FlippedShape.init(graph: graph)
    //    let tri3 = Triangle.init(size: 3)
    //    protocolFlip(protocolFlip(tri3)); //Error，因为protocolFlip返回的是协议类型

}

//你不能将 "具有关联类型的协议类型" 作为方法的返回类型，因为此协议有一个关联类型。
//你也不能将它用于对泛型返回类型的约束，因为函数体之外并没有暴露足够多的信息来推断泛型类型,如：
// 错误：有关联类型的协议不能作为返回类型。
//func makeProtocolContainer<T>(item:T) -> Container {
//    return [item]
//}
// 错误：没有足够多的信息来推断 C 的类型。
//func makeProtocolContainer<T, C:Container>(item:T) -> C {
//    return [item]
//}

//而使用不透明类型 some Container 作为返回类型，
//就能够明确地表达所需要的 API 契约 —— 函数会返回一个集合类型，但并不指明它的具体类型
func makeOpaqueContainer<T>(item:T) -> some Container {
    return [item]
}



func OpaqueTypeUsage() -> Void {
////    Triangle.usage()
//    let tri3 = Triangle.init(size: 3)
//    let reTri = FlippedShape.init(graph: tri3)
//
//    print(reTri.draw())
//    print(tri3.draw())
    
    JoinedShape<Triangle, Triangle>.usage()
    
    
}
