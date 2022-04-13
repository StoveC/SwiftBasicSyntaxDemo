//
//  ErrorThrows.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation



enum VendingMachineError:Error {
    case invalidSelection                       //选择无效
    case insufficientFunds(coinsNeeded: Int)    //金额不足
    case outOfStock                             //缺货
}
struct Item {
    var price:Int
    var count:Int
}
//自动售货机类
class VendingMachine {
    
    
    //存货清单
    var inventory = [
        "Candy Bar":Item(price: 2, count: 3),
        "Chips":Item(price: 2, count: 12),
        "Pretzels":Item.init(price: 2, count: 10),
    ]
    
    
    /// 购买货物
    /// - Parameters:
    ///   - name: 货物名字
    ///   - money: 投入的硬币数
    /// - Throws: 抛出某些错误
    func buy(itemName name:String, money:Int) throws {
        //如果没有这种货，抛出 “选择无效”
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        //如果存货不足1，抛出 “缺货”
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        //如果投入的硬币不足，抛出“金额不足”
        guard money > item.price  else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - money)
        }


        inventory[name]?.count -= 1
        //var newItem = item
        //newItem.count -= 1
        //inventory[name] = newItem
        
        print("购买 \(name) 成功，找余\(money - item.price)")
        
        //swift 中double和int不能直接比较大小、加减乘除：
        //let one:Int = 1
        //let two:Double = 2
        //print(one + two)
    }
    
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
    ]
    
    func buyFavoriteSnacka(person:String, vendingMachine:VendingMachine,  money:Int) throws -> Void  {
        let favoritesnacks = favoriteSnacks[person] ?? "Candy Bar"
        
        try vendingMachine.buy(itemName: favoritesnacks, money: money)
    }
    
    class func usage() -> Void {
        //下面演示do-catch的使用
        let  machine = VendingMachine.init()
        let somethingToBuy = "Candy Bar"
        do {
            try machine.buy(itemName:somethingToBuy , money: 20)
            print("购买\(somethingToBuy)成功")
        } catch VendingMachineError.outOfStock {
            print("货物不足")
        }catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeeded){
            print("硬币不足，还缺\(coinsNeeded)")
        }catch VendingMachineError.invalidSelection where 1 < 2 {
            print("选择无效")
        }catch where 5 < arc4random_uniform(8) {
            print("1 < 2 未知错误：\(error)")
        } catch {
        //这个子句没有指定匹配模式，代表它可以匹配所有错误，并且有一个名为error的常量参数。
            print("未知错误：\(error)")
        }
    }
    /*
     catch 子句不必将 do 子句中的代码所抛出的每一个可能的错误都作处理。如果所有 catch 子句都未处理错误，错误就会传递到周围的作用域。然而，错误还是必须要被某个周围的作用域处理的。在不会抛出错误的函数中，必须用 do-catch 语句处理错误。而能够抛出错误的函数既可以使用 do-catch 语句处理，也可以让调用方来处理错误。如果错误传递到了顶层作用域却依然没有被处理，你会得到一个运行时错误。
     */
}
