//
//  AccessControl.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/11.
//

import Foundation

//open 只能作用于类和类的成员，它和 public 的区别主要在于 open 限定的类和成员能够在模块外能被继承和重写，在下面的 子类 这一节中有详解。将类的访问级别显式指定为 open 表明你已经设计好了类的代码，并且充分考虑过这个类在其他模块中用作父类时的影响。


open class SomeOpenClass {
    open var someOpenProperty = 0
    public var somePublicProperty = 0            // 显式 public 类成员
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
    
}

public class SomePublicClass {                  // 显式 public 类
    open var someOpenProperty = 0
    public var somePublicProperty = 0            // 显式 public 类成员
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

class SomeInternalClass {                       // 隐式 internal 类
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

fileprivate class SomeFilePrivateClass {        // 显式 fileprivate 类
    func someFilePrivateMethod() {}              // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

private class SomePrivateClass {                // 显式 private 类
    func somePrivateMethod() {}                  // 隐式 private 类成员
}


func accessControlUsage() {
    let op = SomeOpenClass.init()
    print(op.someOpenProperty, op.somePublicProperty, op.someInternalProperty, op.someFilePrivateMethod())
    //op.somePrivateMethod() 不可调用
    
    let pub = SomePublicClass.init()
    print(pub.someOpenProperty, pub.somePublicProperty, pub.someInternalProperty, pub.someFilePrivateMethod())
    //pub.somePrivateMethod 不可调用
    
    let inter = SomeInternalClass.init()
    print(inter.someInternalProperty)
}
