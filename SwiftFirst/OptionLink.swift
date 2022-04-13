//
//  OptionLink.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation

//MARK: - 可选数据类型
func optionType(){
    //可选数据类型：可能有值，也可能没值，没值时就是nil
    //可选类型可以置空，确定类型的不能置空
    
    //声明方式有：
    var _:Optional<Int> = nil
    var _:Optional<Int> = 11
    var _:Int? = nil
    var _:Int? = 11
    var _:Int! = nil
    var _:Int! = 11
    
    var num1:Int? = nil
    //以!来声明的可选类型可以隐式展开
    var num2:Int! = nil
    
    //赋值：
    //赋值操作与正常变量无异：
    num1 = 10
    num2 = 100
    
    //打印时不管是不是可以隐式展开类型的可选类型，都得显示展开，或者提供默认值，否则有warming
    print(num1!, num2!,
          num1 ?? "空", num2 ?? "空",
          num1 as Any, num2 as Any)
    
    //取值：
    //取值时需要使用!强制解析，或者使用??语法，或者可选绑定
    //强制类型解析：可以拿到真实的值，前提是可选数据类型里面有值，如果是nil，那么崩溃。
    //声明时使用!关键字则可以隐式展开
    
    //强制解析
    num1 = 2 * num1!
    
    //??语法
    num1 = 2 * (num1 ?? 10)
    
    //可选绑定
    if let num = num1 {
        num1 = 2 * num
    }
    
    //num2隐式展开
    num1 =  2 * num2
    
    //在可选链式调用一样，可以隐式展开的可选类型在调用链中也可以不用使用!强制解析
}

//MARK: - 可选链式调用
//可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是 nil，那么调用将返回 nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败，即返回 nil。

//通过在想调用的属性、方法，或下标的可选值后面放一个问号（?），可以定义一个可选链。这一点很像在可选值后面放一个叹号（!）来强制展开它的值。它们的主要区别在于当可选值为空时可选链式调用只会调用失败(指返回nil)，然而强制展开将会触发运行时错误。
class Room {
    var bed:Bed?
}
class Bed {
    var numOfQuilt = 0
    
    func foldQuilt() ->Void {
        print("All of the quilt is fold")
    }
    
    //该下标用来判断床上的被子数是否多等于i
    subscript(i:Int) -> Bool {
        return i < numOfQuilt
    }
    
    func f() -> String? {
        return "Str"
    }
    
    static func usage() {
        let r = Room()
        //可选链式调用，如果bed没有值，那么调用失败，返回nil
        if let num = r.bed?.numOfQuilt {
            print("num of quilt in the room is \(num)")
        }else {
            print("There is no bed in the room")
        }
        
        //这里使用了强制解析，如果bed没有值，那么会触发运行时错误
        let num = r.bed!.numOfQuilt
        print("num of quilt in the room is \(num)")
        
        
        //++++++++++++++++++技巧++++++++++++++++++++  Begain
        //目的：为r.bed?.numOfQuilt赋值
        //方式1，计算后直接赋值:
        let n = Int(arc4random_uniform(20) + 97)
        if (r.bed?.numOfQuilt = n) != nil {
            print("赋值成功")
        }
        
        //方式2，通过闭包计算:
        r.bed?.numOfQuilt = {
            print("赋值成功")
            let n = Int(arc4random_uniform(20) + 97)
            return n
        }()
        
        //方式2的优越性：
        //1.在赋值不成功的情况下，避免了对n的计算(如果n的计算是十分复杂的话，那么方式2就特别得好)，因为赋值不成功，所以闭包是不会被调用的
        //++++++++++++++++++技巧++++++++++++++++++++  End
        
        
        //通过可选链式调用来调用方法:
        //没有返回值的方法其实有隐式返回值Void，所以可选链式调用没有返回值的方法的返回类型是Void?，而不是Void，所以可以据此判断方法是否调用成功
        if r.bed?.foldQuilt() == nil {
            print("foldQuilt 方法调用失败")
        }else {
            print("foldQuilt 方法调用成功")
        }
        
        //通过可选链式调用访问下标
        if let un = r.bed?[2] {
            if un {
                print("房间内被子的数量大等于2")
            }else {
                print("房间内被子的数量小于2")
            }
        }else{
            print("还没有房间")
        }
        
        //访问<下标返回值>为可选类型的的返回值，感觉这边没有必要单独分出为一例，反正都是对可选类型指向某些操作：
        var dict = ["one":[1.1, 1.5, 1.3], "two":[2.2, 2.7] ]
        dict["one"]?[1] = 1.667
        dict["two"]?[0] = 2.8
        
        if let cnt = r.bed?.f()?.count {
            print("数量为\(cnt)")
        }
    }
}
//连接多层可选链式调用：
/*
 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级。
 也就是说：
 如果你访问的值不是可选的，可选链式调用将会返回可选值。
 如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。

 因此：
 通过可选链式调用访问一个 Int 值，将会返回 Int?，无论使用了多少层可选链式调用。
 类似的，通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int??。
 */

class A {
    var a:A?
    var aa = A()
    func fa() -> A? {
        return A()
    }
    func faa() -> A {
        A()
    }
    subscript(a:Int=0) -> A? {
        return A()
    }
    subscript(aa:Int) -> A {
        return A()
    }
    static func usage() -> Void {
        let aClass = A()
        //语法记忆技巧：在调用链上所有值为可选类型的元素后面加? 如：
        print(aClass.aa.aa.faa().a?.a?.fa()?.faa().a?.fa()?.faa()[2][]?[2][]?[]?[2][2][2][] ?? "[空]")
    }
}

class Opt {
    weak var Op1:Opt?
    weak var Op2:Opt!
    init() {
        Op1 = self
        Op2 = self
    }
}


func Optf() -> Void {
    let k = Opt.init()
    
    
    if let _ = k.Op1?.Op1?.Op1?.Op1 {
        print("Op1?")
    }else {
        print("Op1? fai")
    }
    
    
    if let _ = k.Op1!.Op1!.Op1!.Op1 {
        print("Op1!")
    }else {
        print("Op1! fai")
    }
    
    //相当于k.Op2!.Op2!.Op2!.Op2
    if let _ = k.Op2.Op2.Op2.Op2 {
        print("Op2")
    }else {
        print("Op2 fai")
    }
    
    if let _ = k.Op2!.Op2!.Op2!.Op2 {
        print("Op2!")
    }else {
        print("Op2! fai")
    }
    
    if let _ = k.Op2?.Op2?.Op2?.Op2 {
        print("Op2?")
    }else {
        print("Op2? fai")
    }
}
