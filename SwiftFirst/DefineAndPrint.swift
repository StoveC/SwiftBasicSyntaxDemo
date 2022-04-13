//
//  DefineAndPrint.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation



func printUsage() {
    //如果用默认的print，那么输出效果是：以空格作为分隔符，print结束自动输出回车
    print("2","dwdw","dwdwdw","wdwwdwd")
    
    //只指定末尾符为"end_______\n"
    print("3","dwdw", "dwdwdw", "dwdwdw", terminator: "end_______\n")
    
    //只指定分隔符位" * "
    print("4","dwdw", "dwdwdw", "dwdwdw", separator: " * ")
    
    //指定分隔符和末尾符，separator:后是各输出元素间的分隔符，terminator:后是print结束后输出的内容
    print("1","dwdwd","dwdwd","wdwwwd", separator: " + " , terminator: "end__\n")
    
    let inputs = readLine(strippingNewline: true)
    
    print(inputs ?? "inputs=空");
    
    print(type(of: Float(3.14)))
    print(type(of: 3.14))
    print(Int16.max)
}


//字面量
func writeType (){
    //Int
    let _ = 3
    
    //一百万，Int
    let _ = 100_0000
    
    //一万，Int
    let _ = 0001_0000
    
    //Double
    let _ = 3.14
    
    //二进制，Int
    let _ = 0b1001101
    
    //十六进制，Int
    let _ = 0x8878273fc7a
    
    //八进制，Int
    let _ = 0o5165367
    
    //科学计数法，Double
    let _ = 0x5p3   //5*2^3
    
    //科学计数法，Double
    let _ = 7e14    //7*10^14
    
    //Character
    let _:Character = "x"
    
    //String
    let _ = "x"
}

//变量定义
func defin() {
//    变量名可以由字母，数字和下划线组成。
//    变量名需要以字母或下划线开始。
//    Swift 是一个区分大小写的语言，所以字母大写与小写是不一样的。
//    变量名也可以使用简单的 Unicode 字符
//    类型推断：不用指明数据类型，自动推断数据类型
    //var关键字用来定义变量:
    //var 变量名:变量类型 = 数据、var 变量名 = 数据、var 变量名:变量类型
    
    //let关键字用来定义常量:
    //let 变量名:变量类型 = 数据、let 变量名 = 数据、let 变量名:变量类型
    
    
    
    //var关键字用来定义常量
    var _:Bool = true
    //自动类型推断
    var _ = true
    var _:Bool
    
    //let关键字用来定义常量
    let _:Bool = true
    //自动类型推断
    let _ = true
    let _:Bool
    
    
    //如果要用某个关键字作为变量名，可以把变量名用重音符``连接起来
    let `var` = 11
    
    //Unicode命名
    let 是否:Bool
    
    //可以通过 type(of: T)来判断类型
    print(type(of: `var`), type(of: 是否))
    
    
    //强转：
    //整型一定可以转为Double，所以返回的不是可选类型
    let _:Double = Double(23)
    //字符串强转不一定成功，所以返回可选类型
    let _:Double = Double("23")!
    
    //基础数据类型定义：
    let _:Int = Int.init("1")!
    let _:Int = Int(1.111)
    let _ = 1
    
    //字符串定义：
    let _:String
    let _ = "123"
    
    //数组定义：
    let _:Array<Int>
    let _:[Int]
    let _ = [1, 2, 3]
    
    
    
    //字典定义：
    let _:Dictionary<String, Int>
    let _:[String:Int]
    let _ = ["1":1, "2":2, "3":3]
    
    //集合定义(无序、互异、确定)
    let _:Set<Int>
    let _ = Set.init([1, 2, 3])
    let _ = Set([1, 2, 3])
    
    // 元组
    var _:(Int, Double, String, Bool) = (1, 223.1, "World", false)
    var _ = (1, 223.1, "World", false)
}


func space() {
    var num:Int = 3;
    //运算符不能直接跟在变量或常量的后面
    print(1 + 1)
    print(1+1)
    print(num+1)
    print(num + 1)
    num = 2
    num += 3
    //几种会错误的写法：
    //print(1+ 1)
    //print(1 +1)
    //num= 2
    //num =2
    //print(num +1)
    //print(num+ 1)
    //num+= 3
    //num +=3
}

//给变量起别名、类型转换
func aliasAndMemoryLayoutUse() {
    //给变量起别名：
    typealias Length = Double
    let thousand:Length = 10
    print(thousand)
    
    
    //实际使用的空间大小
    let _ =  MemoryLayout<Int>.size
    //实际占用的空间大小
    let _ = MemoryLayout<Int>.stride
    //内存对齐
    let _ = MemoryLayout<Int>.alignment
    
    let intNum:Int = 0
    
    let _ = MemoryLayout.size(ofValue:intNum)
    
    let _ = MemoryLayout.stride(ofValue: intNum)
    
    let _ = MemoryLayout.alignment(ofValue: intNum)
    
}
 
