//
//  MemorySafe.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/10.
//

import Foundation
//内存访问的时长要么是瞬时的，要么是长期的。
//如果一个访问不可能在其访问期间被其它代码访问，那么就是一个瞬时访问。
//正常来说，两个瞬时访问是不可能同时发生的。大多数内存访问都是瞬时的。

//出现长期访问的几种情况：
//in-out 参数的函数和方法
//结构体的 mutating 方法

func balance(_ x: inout Int,_ y: inout Int)  {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

struct XPlayer {
    var name: String
    var health: Int
    var energy: Int
    
    let maxHealth = 10
    mutating func restoreHealth() {
        health = maxHealth
    }
    
    mutating func shareHealth(with teammate: inout XPlayer) {
        balance(&health, &teammate.health)
    }
    
    func addHealth(to teammate: inout XPlayer)  {
        teammate.health += health
    }
    
    func makeIncreaseByHealth(num: inout Int)  {
        num += health
    }
    
}

//在实践中，大多数对于结构体属性的访问都会安全的重叠。例如，将变量会发生重叠访问的变量 改为本地变量而非全局变量，编译器就会可以保证这个重叠访问是安全的

func memorySafeUsage() {
    var x = 23
    var y = 100
    
    balance(&x, &y) //正常
//    balance(&x, &x) //编译时Error
    
    //当结构体，元组和枚举是全局变量时，同时对其成员进行修改运行时会Error，如果是局部变量，则不会Error
    var playerInfo = (health:100, energy: 20)
    var playerNemo = XPlayer.init(name: "player Nemo", health: 10, energy: 30)
    var playHank = XPlayer.init(name: "player Hank", health: 8, energy: 14)
    
    
    //当playerInfo与playerNemo为全局变量时，下面两个语句运行时Error
    balance(&playerInfo.health, &playerInfo.energy)
    balance(&playerNemo.health, &playerNemo.energy)
    
    
    playerNemo.shareHealth(with: &playHank)//正常
//    playerNemo.shareHealth(with: &playerNemo)   //编译时Error
    
    
    var step = 100
    func addStep(num:inout Int) {
        num += step
    }
    
    addStep(num: &x)    //正常
    
    addStep(num: &step) //运行时Error
    //因为函数调用后，step作为inout的 访问独占权 被addStep持有，
    //而addStep内部需要对step进行读操作(也需要访问独占权)，所以Error。
    
    //按照同样的道理，下面这两个语句应该也会Error，但实际上即使把Nemo变为全局变量也不会Error
//    playerNemo.addHealth(to: &playerNemo)
//    playerNemo.makeIncreaseByHealth(num: &playerNemo.health)
    
    print(playerNemo)
}

//限制结构体属性的重叠访问对于保证内存安全不是必要的。保证内存安全是必要的，但因为访问独占权的要求比内存安全还要更严格——意味着即使有些代码违反了访问独占权的原则，也是内存安全的，所以如果编译器可以保证这种非专属的访问是安全的，那 Swift 就会允许这种行为的代码运行。当你遵循下面的原则时，编译器可以保证结构体属性的重叠访问是安全的：
/**
 * 你访问的是实例的存储属性，而不是计算属性或类的属性
 * 结构体是本地变量的值，而非全局变量
 * 结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了
 */


