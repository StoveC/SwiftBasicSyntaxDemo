//
//  IndexSyntax.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation


//MARK:-下标语法
//下面两个展示了实例的下标语法
//定义了一个进行字符串值的平方操作的结构体
struct SquareOperator {
    subscript (str:String) -> String? {
        get {
            var sum:String?
            if let num = Double(str) {
                sum = String(num*num)
            }else if let num = Int(str) {
                sum = String(num*num)
            }
            return sum
        }
    }
    
    static func indexSyntaxUsage (numStr:String = "0") {
        let myOperator = SquareOperator()
        print(myOperator[numStr] ?? "Null")
        print(SquareOperator()[numStr] ?? "Null")
    }
}
//定义了一个矩阵结构体
precedencegroup g1 {
    associativity: left
    
}

infix operator ^ : g1
struct Matrix {
    var rows:Int
    var columns:Int
    var grid:[Double]
    
    init(rows:Int, columns:Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func isIndexValid(_ row:Int, _ column:Int) -> Bool {
        return 0<row&&row<rows  &&  0<column&&column<columns
    }
    
    subscript(row:Int, column:Int) ->Double {
        get {
            assert(isIndexValid(row, column), "Index out of range")
            return grid[row*columns + column]
        }
        set {
            assert(isIndexValid(row, column), "Index out of range")
            grid[row*columns + column] = newValue
        }
    }
    // 加号运算符重载
    static func + (m1:Matrix, m2:Matrix) -> Matrix {
        assert(m1.rows == m2.rows && m1.columns == m2.columns, "Matrix size error")
        var m = Matrix.init(rows: m1.rows, columns: m2.rows)
        for i in 0..<m1.grid.count {
            m.grid[i] = m1.grid[i] + m2.grid[i]
        }
        return m
    }
    
    static func - (m1:Matrix, m2:Matrix) -> Matrix {
        assert(m1.rows == m2.rows && m1.columns == m2.columns, "Matrix size error")
        var m = Matrix.init(rows: m1.rows, columns: m1.columns)
        for i in 0..<m1.grid.count {
            m.grid[i] = m1.grid[i] - m2.grid[i]
        }
        return m
    }
    
    static func * (m1:Matrix, m2:Matrix) -> Matrix {
        assert(m1.columns == m2.rows, "Matrix size error")
        var m = Matrix.init(rows: m1.rows, columns: m2.columns)
        for i in 0..<m1.rows {
            for j in 0..<m2.columns {
                for k in 0..<m1.columns {
                    m[i, j] += m1[i, k] * m2[k, j]
                }
            }
        }
        return m
    }
    
    
    static func ^ (m:Matrix, n:Int) -> Matrix {
        assert(n > 0, "party n <= 0")
        var i = 2
        var result = m
        while i <= n {
            result = result * result
            i *= 2
        }
        i /= 2
        if i==n {
            return result
        }else {
            return result * (m ^ (n - i))
        }
    }
    
    static func usage() {
        let m1 = Matrix(rows: 3, columns: 3)
        let m2 = Matrix(rows: 3, columns: 3)
        let m = m1 * m2
        //偶然发现这样使用不会报错，原因待定
//        print(isIndexValid(m))
        print(m.isIndexValid(100, 2), m[2, 3], m[1, 3])
    }
}

//下面展示类型的下标语法
//可以通过在 subscript 关键字之前写下 static 关键字的方式来表示一个类型下标。类类型可以使用 class 关键字来代替 static，它允许子类重写父类中对那个下标的实现。下面的例子展示了如何定义和调用一个类型下标
enum PlanetWithIndexSyntax:Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n:Int) ->PlanetWithIndexSyntax {
        return PlanetWithIndexSyntax(rawValue: n)!
    }
    static func usage() {
        let mars = PlanetWithIndexSyntax[4]
        print(mars)
    }
}
