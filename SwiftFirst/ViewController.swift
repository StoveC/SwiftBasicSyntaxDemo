//
//  ViewController.swift
//  SwiftFirst
//
//  Created by Stove on 2020/10/8.
//

import UIKit


/// 演示在Xcode中使用md
/// - Parameter str: 字符串参数
///
/// - Returns: 返回传入的字符串
///
/// - Precondition: **str不为空**
///
/// - Requires:**Requires, Requires, Requires**
///
/// - Note:函数描述有点长
///
/// - SeeAlso:
/// http://hello.com
///
/// - Warning: 一个普通的warming
///
/// - Version: 1.3
///
/// - Todo: 未来的变更
/// - Author: Stove
///
///  # example: #
/// ```
/// //使用示例：
///let str = "Hello, World !"
///let ret = markdownFunc(str: str)
///print(ret)
/// ```
/// - Remark:
///remark, remark, remark, remark
///
func markdownFunc(str:String) -> String {
    return str
}
enum BBig:Int {
    case d
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        BasicDataStructureMain()
    }
}


//MARK: - 扩展

extension Double {
    var km:Double {
        return self * 1_000.0
    }
    
    var m:Double {
        return self
    }
    
    var cm:Double {
        return self/100.0
    }
    
    var mm:Double {
        return self/1_000.0
    }
    
    var ft:Double {
        return self/3.28084
    }
    
    static func usage() -> Void{
        let t = 3.0;
        print(t.km, t.m, t.cm, t.mm, t.ft)
    }
}


func f() {
    let _ = Senum.ABC("dwdij")
    
    printUsage()
}



public enum Senum {
    case ABC(String)
}
