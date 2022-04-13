//
//  BasicDataStructure .swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/6.
//

import Foundation

func BasicDataStructureMain() {
    let digitNameMap = [
        0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]
    
    let numberArr = [16, 58, 510]
    let stringArr = numberArr.map { (number) -> String in
        var number = number
        var output = ""
        repeat {
            output = digitNameMap[number % 10]! + output
            number /= 10
        } while number > 0
        return output
    }
    print(stringArr)
}

//元组数据类型
func tupleArr() {
    
    //元组：不同的数据类型封装在一起
    //定义
    var tuple1 = (1, 13.2, "Hello", true)
    
    //也可以在定义时指明元素的数据类型：
    var tuple2:(Int, Double, String, Bool) = (1, 223.1, "World", false)
    
    //空元组
    let _: () = ()
    
    
    print(tuple1, tuple2)
    
    //元组取值、改值：
    print(tuple1.0,tuple2.1)
    tuple2.1 = 3.14
    
    
    //元组之间的赋值要求两个元组的数据组成相同，如果不同会报错
    tuple1 = tuple2
    
    
    //元组的相互赋值是值的拷贝，不是引用，所以修改tuple1的值，并不会对tuple2产生影响
    tuple1.2 = "zxc"
    print("arr1=", tuple1, "arr3=", tuple2)
    
    //元组在定义时可以指定元素的名称和数据类型；
    let tuple3 = (n0:"he", "zxc", n2:22)
    print(tuple3.n0, tuple3.1, tuple3.n2)
    
    //定义多个变量：
    let (c1,c2,c3) = (1, 3, "ueureruy")
    var (v1,v2) = (2,true)
    v1 = 34
    v2 = false
    print(c1,c2,c3,v1,v2)
    
    //元组比较, 从左到右、逐个比较。2==2，"a"<"b" 所以返回true
    if (2, "a", 22) < (2, "b", 12) {
        print("\((2, "a", 22)) < \((2, "b", 12))")
    }
    //空元组()，的类型是Void
    if  type(of: ()) == Void.self {
        print("dwdw")
    }
}

//字符串操作
func strOpreation() {
    var str:String = "12345678"
    str = str + "9"
    
//    //获取字符串长度：
//    print(str.count)
    
//    //通过字符串下标进行访问，下标数据类型必须为String.Index

//    //访问第一个字符
//    print(str[str.startIndex])
    
//    //访问最后一个字符
//    print(str[str.index(before: str.endIndex)])
    
//    //获得0+4的下标
//    let index4 = str.index(str.startIndex, offsetBy: 4)
//    let startIndex = str.startIndex
    
//    //访问一定范围的字符
//    print(str[startIndex...index4])
    
//    //获取长度为四的子字符串
//    print(str.prefix(4))
    
//    //获取后两位字符
//    print(str[str.index(str.endIndex, offsetBy: -2)..<str.endIndex])
    
//    //判断是否包含某个字符串
//    print(str.contains("112"),str.contains("12"))
    
//    //只要包含一个相同字符就返回true
//    print(str.contains(where: String.contains("jjjj级2")))
    
//    //判断是否有前缀
//    print(str.hasPrefix("1231"),str.hasPrefix("12"),str.hasPrefix(""))
    
//    //判断是否有后缀
//    print(str.hasSuffix("899"),str.hasSuffix("89"),str.hasSuffix(""))
    
//    //追加字符串
//    str.append("abc")
//    print("追加后：\(str)")
    
    //判断字符串相等
    //"eq"=="eq"
    
//    str.insert(contentsOf: "hello", at: str.index(str.startIndex, offsetBy: 2))
//    print("在原来字符串中，索引为2的位置插入新字符串=" + str)
//
//    let index1 = str.index(str.startIndex, offsetBy: 1)
//    let index2 = str.index(str.startIndex, offsetBy: 3)
//    let range = index1...index2
//
//    str.replaceSubrange(range, with: "123")
//    print("将原来字符事中的素引为1到3的位置，馨换成字符串123 =" + str)
    
//    let new_value = str.replacingOccurrences(of: "llo", with: "Ba")
//    print("将原来字符串中的JK替换成888,返回个新字符串= " + new_value)
//
//    str.removeSubrange(str.index(str.startIndex, offsetBy: 2)...str.index(str.startIndex, offsetBy: 4))
//    print("删除原来字符事中的素引为1到3位置的字符事=" + str)
    
//    //多行文本：使用""" xxxx  """ 语法，注意点：对齐
//    let valStr =    """
//                    feuyfgu
//                        iofhfe
//                    gyqguy
//                    """
//    print(valStr)
    
    //输出引号:使用##语法，或者转义\"
//    print("\"\"hduwhu\"\"")
    // ##语法：被#包围的字符串中，不进行转义，但是该字符串中的出现#的，在#前面的字符会被转义
    //#"zxc\n"# -> zxc\n
    //#"zxc\#n"# == ##"zxc\##n"## ->zxc + 换行
    if str.isEmpty {
        print("str: \(str) is empty")
    }
    
    //创建空字符串
    let empStr1 = String()
    let empStr2 = ""
    
    //字符串拼接：
    let flo = 3.14
    
    str += String(12)
    
    str = str + "派等于\(flo)" + "World"
    
    print(str)

    str += empStr1
    
    str += empStr2
    
    str.append("dfghj")
    
    print("str:" + str, type(of: str), type(of: type(of: str)))
    
    print("str = \(str)")
    
    print("str\(str)的utf8编码：")
    for code in str.utf8 {
        print(code,type(of: code))
    }
    
    print("str\(str)的utf16编码：")
    for code in str.utf16 {
        print(code,type(of: code))
    }
    
    //unicode 转义，合成'e' + ' ́' = 'é'。可扩展的字形集。扩展后如果两个字符的语言意义和外形一样，那么他们可以被判定为等价。
    //       'e'      ' ́'          'é'          'é'
    print("\u{65}","\u{301}","\u{65}\u{301}","\u{E9}")
    
    
    str = "0123456789"
    
    var idx:String.Index = str.index(str.startIndex, offsetBy: 3)
    
    print(str[idx])
    
    //位置3移除字符，结果：012456789
    str.remove(at: idx)
    
    print(str)
    //位置3插入字符，结果：012X456789
    str.insert("X", at: idx)
    
    // 移除一个范围的内容
    str.removeSubrange(str.startIndex...str.startIndex)
    
    print(str)
    
    idx = str.firstIndex(of: "5") ?? str.startIndex
    
    let subStr = str[...idx]
    
    print(subStr)
    // 返回值是个闭包
    let _ = String.contains("jjjj级2")
    // 这里应该是对 str 中的每个元素都调用闭包，满足情况则放回 true
    print(str.contains(where: String.contains("jjjj级2")))
    
    /*
     //访问一定范围的字符
     
     //获取长度为四的子字符串
     
     //获取后两位字符
     
     //判断是否包含某个字符串
     
     //只要包含一个相同字符就返回true
     
     //判断是否有前缀
         
     //判断是否有后缀
         
     //追加字符串
     
     //在原来字符串中，索引为2的位置插入新字符串
     
     //将原来字符串中的索引为1到3的位置，替换成字符串123
     
     //将原来字符串中的JK替换成888,返回个新字符串
 
     //删除原来字符串中的索引为1到3位置的字符串
         
     //多行文本：使用""" xxxx  """ 语法，注意点：对齐
     */
    
}

//数组操作
func arrOpreation() {
    let _ = ["hello", "world"]

    let _:[String] = ["hello", "world"]
    
    let _:Array<String> = ["hello", "world"]

    let _:Array<String>? = ["hello", "world"]

    let _ = [1, 2, 3, "wdwd"] as [Any]
    
    let _:[Any] = [1, 2, 3, "wdwd"]
    
    //用let定义的常量， 不可变数组，不能改变长度和数据，但是可以取值
    let _ = [4,5,6]

    //3维数组
    let _ :[[[Int]]] = [
        [[3, 0]],[[9]]
    ]
    
    //通过Array初始化器， 生成-个，初始值为"-1", "-1", "-1", 的数组
    let _ = Array(repeating: "-1", count:3)
    
    var arr:Array<String> = [String]() //通过初始化器，定义可变的空数组
    arr.append("1") //在尾部添加新数据
    
    
    print(arr, arr.count, arr.endIndex, arr.last!, arr.first!)
    
    arr.replaceSubrange((0..<arr.count), with: ["7","8","9"]) //全部替换成7, 8, 9
    
    //数组合并
    arr += ["910"]
    
    //插入
    arr.insert("23", at: 2)
    
    //移除
    arr.remove(at: 1)
    
    //移除最后一个元素
    print(arr.removeLast())
    
    //移除所有元素
    print(arr.removeAll())
    
    arr = ["0x","1x","2x","3x","4x","5x","6x"]
    
    //遍历数组，i为下标，v是i对应的值
    for (i, v) in arr.enumerated() {
        print(i, v)
    }
    /*
     结果：
        0 0x
        1 1x
        2 2x
        3 3x
        4 4x
        5 5x
        6 6x
    */
    
    //数组的sort方法详见闭包操作"func closureUsage"
    
    /*
     //在尾部添加新数据
     //获取数组大小、截止下标、起始下标、最后一个元素、第一个元素
     //特定范围的元素替换
     //数组合并
     //插入元素
     //移除元素
     //移除最后一个元素
     //移除所有元素
     //遍历数组
     */
    
}
class Abb {
    var i = 0
    func T() {
        
    }
}

struct Bcc {
    var a = Abb.init()
    static func test() {
        let b = Bcc.init()
        b.a.i = 23
    }
}
class ej {
    @inline(__always) func TT() {
        
    }
}

struct ks {
    @inline(__always) func TT() {
        
    }
}
//闭包操作
func closureUsage () {
    
    //在 Swift 中，函数也是一种特殊的闭包。
    var arr = [1, 3, 9, 7, 4, 6, 0, 8, 4, 2, 5];
    
    //从小到大排序的闭包
    func b1(n1: Int, n2: Int) -> Bool {
        n1 < n2
    }
    
    let _ = b1
    
    //从大到小排序的闭包
    func b2(n1: Int, n2: Int) ->Bool {
        return n1 > n2
    }
    
    //从小到大排序，array会被修改
    arr.sort(by: b1)
    //从大到小排序，array会被修改
    arr.sort(by: b2)
    //从小到大排序，array不会被修改，函数返回一个新数组
    print(arr.sorted(by: b1))
    //从大到小排序，array不会被修改，函数返回一个新数组
    print(arr.sorted(by: b2))
    
    let _ = { (n: Int) -> Int in
        return n
    }
    
    //闭包表达式语法，从大到小排序
    arr.sort(by: { (n1:Int, n2:Int) -> Bool in
        n1 > n2
    })
    
    //根据上下文自动推断闭包类型，从小到大排序
    print(arr.sorted(by: { (v1, v2) -> Bool in
        return v1 > v2
    }))
    
    //根据上下文自动推断闭包类型，从大到小排序
    arr.sort(by: { v1, v2 in
        v1 > v2
    })
    
    //闭包参数缩写，从小到大排序
    arr.sort(by: {$0 < $1})
    
    //运算符方法，从大到小
    arr.sort(by: >)
    
    //尾随闭包，从大到小
    arr.sort() {$0 > $1}
    
    //尾随闭包，从小到大
    arr.sort {$0 < $1}
    
    arr.sort() { v1, v2 in
        return v1 < v2
    }
    
    //闭包实现数字到字符串的转化
    let digitNameMap = [
        0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]
    
    let numberArr = [16, 58, 510]
    let stringArr = numberArr.map { (number) -> String in
        var number = number
        var output = ""
        repeat {
            output = digitNameMap[number % 10]! + output
            number /= 10
        } while number > 0
        return output
    }
    // ["OneSix", "FiveEight", "FiveOneZero"]
    print(stringArr)
    
    //下面介绍闭包的值捕获
    
    //闭包incBy10内部持有一个 Int 变量，每次调用闭包都会使该变量的值 + 10，
    //且该闭包会返回该变量
    let incBy10 = makeIncrementer(num: 10)
    
    for _ in 0...9 {
        print(incBy10())
    }
    
    print(incBy10())
    
    //逃逸闭包
    //1.当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，
    //我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，
    //你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
    
    //2.一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中
    
    //3.标记为 @escaping 的闭包必须显式地引用 self，非逃逸闭包可以隐式引用 self。
    
    //4.当非逃逸闭包函数是形参时，不能存储在属性、变量或任何 Any 类型的常量中，
    //因为这可能导致值的逃逸。

    //5.当非逃逸闭包函数是形参时，不能作为实参传递到另一个非逃逸闭包函数中。
    //这样的限制可以让 Swift 在编译时就完成更好的内存访问冲突检查，而不是在运行时。
    var clsrAry:[()->()] = []
    func t(_ clsr:@escaping ()->()) {
        clsr()
        // 这个闭包被放入了 一个外界的 ary，意味着该闭包可能会在本函数调用完后，被执行，既逃逸闭包
        clsrAry.append(clsr)
    }
    
    
    //自动闭包
    //自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。
    //这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。
    //这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
    var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    
    //创建了一个 ()->String 类型的闭包
    let customerProvider = { customersInLine.remove(at: 0) }
    
    print("Now serving \(customerProvider())")
    
    func serve1(custimer custimcustomerProvider:()->String) {
        print("Now serving \(customerProvider())")
    }
    serve1 { () -> String in
        customersInLine.remove(at: 0)
    }
    
    func serve2(customer customerProvider: @autoclosure ()->String){
        print("Now serving \(customerProvider())")
    }
    
    serve2(customer: customersInLine.remove(at: 0))
    
    let obj = NSObject.init()
    var _ = {
        // 定义闭包的捕获列表，可以用来避免循环引用
        [unowned obj, weak ojj = obj]
        (index: Int, stringToProcess: String) -> Void in
        // 这里是闭包的函数体
        let _ = obj
        ojj = nil
        let _ = ojj
    }
    
}

func makeIncrementer (num:Int)-> ()->Int {
    var total = 0
    //1.闭包 "incre" 会捕获 变量total、常量num，所以
    //只要被返回的incre没有被销毁，那么total也会仍然存在。
    
    //2.为了优化，如果一个值不会被闭包改变，或者在闭包创建后不会改变，
    //Swift 可能会改为捕获并保存一份对值的拷贝。
    
    //3.Swift 也会负责被捕获变量的所有内存管理工作，包括释放不再需要的变量。
    
    //4.闭包是引用类型（可以理解为指针），如果你将闭包赋值给了两个不同的常量或变量，
    //两个值都会指向同一个闭包。
    func incre () -> Int {
        total += num
        return total
    }
    
    return incre
}

//集合操作
func setOpreation() {
    //创建集合
//    let set:Set<Int> = [1, 2, 3, 4]
    var set:Set = ["1x", "2x", "3x", "4x"]
    
    //判断集合是否为空
    if set.isEmpty {
        print("\(set) is empty")
    }
    
    //在集合中插入
    set.insert("3x")
    
    
    //移除元素，如果该元素存在，那么返回该元素，否则返回nil
    if let mem = set.remove("s") {
        print("已移除\(mem)")
    }else{
        print("\(set)不包含\"s\"")
    }
    
    if set.contains("1x") {
        print("\(set) 包含\"1x\"")
    }
    
    //移除所有元素
    set.removeAll()
    
    let set2:Set = ["1x", "2x", "a", "b"]
    
    //两集合交集
    print(set.intersection(set2))
    //两集合的并集
    print(set.union(set2))
    //两集合的并集减去交集后剩下的部分
    print(set.symmetricDifference(set2))
    //set减去set2
    print(set.subtract(set2))
    
    if set==set2 {
        print("\(set)==\(set2)")
    }else{
        print("\(set)!=\(set2)")
    }
    
    if set.isSuperset(of: set2) {
        print("\(set) is superSet of \(set2)")
    }else{
        print("\(set) is not superSet of \(set2)")
    }
    
    if set2.isSubset(of: set) {
        print("\(set2) is subSet of \(set)")
    }else{
        print("\(set2) is not subSet of \(set)")
    }
    
    
    /**
     set.isStrictSuperset(of: set2)        set是否真包含set2
     set2.isStrictSubset(of: set)           set2是否真包含与set
     */
}

//字典操作
func dictOperation () {
    //    let d:Dictionary<String,Int> = ["0":0, "1":1]
    //    let d = ["0":0, "1":1, "2":2]

    var dict:[String:Int] = [
        "0x":0,
        "1x":1,
        "2x":2,
        "3x":3,
        "4x":4,
    ]
    //字典的返回值是可选类型，需要解析
    print(dict, dict.count, dict.isEmpty, dict["0x"]!)
    
    //下标语法存值
    dict["5x"] = 5
    //下标语法改值
    dict["0x"] = 39

    //如果有旧值存在，那么返回旧值，否则返回nil
    if let oldValue = dict.updateValue(23, forKey: "3x") {
        print("old is \(oldValue)")
    }

    //通过某个键移除键值对，如果该键值对存在，则返回该键值对的值。否则返回nil
    if let value = dict.removeValue(forKey: "3x") {
        print("removed is \(value)")
    }

    //字典遍历
    for (key, value) in dict {
        print(key,value)
    }

    let _:Dictionary<String,Int>.Keys = dict.keys
    
    //获得由key组成的数组
    let keyArr = [String](dict.keys)
    
    //获得由value组成的数组
    let valueArr = [Int](dict.values)
    
    print("keys:\(keyArr),values:\(valueArr)")
}
