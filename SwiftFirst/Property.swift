//
//  Property.swift
//  SwiftFirst
//
//  Created by Stove on 2021/4/5.
//

import Foundation


//如果结构体内部存储属性没有提供初始值，那么构造时就必须提供一个初始值,已有初始值的属性可以不提供值
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
}


/*
 当定义的结构体是let型时(既 let s = struct()时)，即使内部的存储属性是变量存储属性，s也仍是无法改变属性值的
 对于内部有常量存储属性的结构体，在创建时就必须初始化常量存储属性，且以后无法更改
 */
struct FixedLengthRange {
    var firstValu:Int
    let length:Int
}
/*
 存储属性分为常量存储属性和变量存储属性
 延时加载属性必须设定为变量存储属性
 */
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    //通过lazy关键字定义延迟加载属性，且该种属性必须有一个设定的初始值
    //lazy属性适用于这样的场景：某个属性的加载会比较耗时，且有时使用该结构体/类时不一定会使用该属性
    lazy var importer = DataImporter()
    var data = [String]()
}
func classAndStruct(str:String) -> String {
    _ = VideoMode();
    _ = Resolution();
    
    let videoMode = VideoMode()
    let resolution = Resolution(width: 30, height: 100)
    videoMode.name = "Hello"
    
    var rang = FixedLengthRange(firstValu: 23, length: 17)
    
    rang.firstValu = 13
    
    print(videoMode.frameRate, resolution.width,"videMode name is \(videoMode.name!)")
    return str
}

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    //计算属性：
    //Xcode代码提示关键词：vargetset
    var center: Point {
        get {
            var center = Point()
            center.x = origin.x + size.width/2
            center.y = origin.y + size.height/2
            return center
            //也可以通过隐式返回：
            //Point(x: origin.x + size.width/2, y: origin.y + size.height/2)
        }
        //set方法，也可以使用默认值newValue
        set(newCenter) {
            origin.x = newCenter.x - size.width/2
            origin.y = newCenter.y - size.height/2
        }
    }
    //只读计算属性：
    //Xcode代码提示关键词：varget
    //必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值
    var area: Double {
        return size.width * size.height
    }
    static func usage() -> Void {
        var square = Rect(origin: Point(x: 100, y: 100), size: Size(width: 30.0, height: 30.0))
        print(square)
        square.center = Point(x: 100, y: 100);
        print(square)
    }
}

class stepCounter {
    var totalStep = 0 {
        //属性观察器，当值将要改变、已经改变时调用，即使新值和旧值完全一样也会调用
        willSet (new) {
            print("total step 会设置成:%d",new)
        }
        //如果没有指定参数名称，那么默认为newValue、oldValue
        //在属性观察器内部对被观测属性再次改值，不会触发属性观察器
        //可以为任何属性添加属性观察器，无论它原本被定义为存储型属性还是计算型属性。
        
        //你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供 willSet 或 didSet 实现也是不恰当。 此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
        didSet {
            if oldValue < totalStep {
                print("增加了\(totalStep - oldValue)步")
            }
        }
    }
    
}

//定义一个属性包装器，需要创建一个定义 wrappedValue 属性的结构体、枚举或者类。
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    //名字必须是wrappedValue，否则报错
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
    init() {
        number = 0;
    }
    init(num:Int) {
        number = num
    }
}

struct smallRectangel {
    //只能指定类型为Int，因为属性包装器内部包装的是Int类型，所以也可以不指定类型
    @TwelveOrLess var width:Int
    @TwelveOrLess var height
}

//TwelveOrLess的拓展版本：SmallNum
@propertyWrapper
struct SmallNumber {
    private var _maximum:Int
    private var _number:Int
    //在属性包装器内部定义一个名为projectedValue的变量，那么可以通过s.$property来访问projectedValue
    //projectedValue可以是任何类型
    var projectedValue = false
    
    var wrappedValue:Int {
        set {
            _number = min(_maximum, newValue)
        }
        
        get {
            return _number
        }
    }
    
    init() {
        _maximum = 12
        _number = 0
    }
    //这个构造器参数名使用wrappedValue有一个好处：外界可以使用这样的代码@SmallNumber var n = 2，来初始化
    init(wrappedValue:Int) {
        _number = wrappedValue
        _maximum = 12
    }
    init(wrappedValue:Int, maximum:Int) {
        _maximum = maximum
        _number = min(wrappedValue, maximum)
    }
}

struct UnitRectangle {
    @SmallNumber var width = 1
    @SmallNumber var height = 1
}

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2) var width;
    @SmallNumber(wrappedValue: 2, maximum: 17) var height
    
    
    init(width w:Int, height h:Int) {
        //可以像这样访问属性，以及属性的呈现值
        width = w
        self.height = h
        $width = $width
        self.$height = self.$height
    }
}
func wrappedValueUse() {
    _ =  smallRectangel(width: TwelveOrLess(), height: TwelveOrLess())
    _ = SmallNumber()
    var s = NarrowRectangle(width: 2, height: 13)
    
    
    print(s.width,s.$width)
    s.width = 100
    print(s.width,s.$width)
    s.width = 1
    print(s.width,s.$width)
}

@propertyWrapper
struct test {
    private var num:Int
    var projectedValue = 3.9
    
    var wrappedValue: Int {
        get {
            return num
        }
        set {
            if newValue > 12 {
                num = 12
                projectedValue = 100.0
            }else{
                num = newValue
                projectedValue = 3.9
            }
        }
    }
    
    init(wrappedValue:Int) {
        num = wrappedValue
        
    }
}

struct ss {
    @test var pro = 2
}


enum SizeEnum {
    case small, large
}

struct SizedRectangle {
    @SmallNumber var width
    @SmallNumber var height
    
    //默认情况下，值类型的属性不能在它的实例方法中被修改。使用关键字mutating就可以在实例方法内部改变值类型属性了
    mutating func resize(to size:SizeEnum) -> Bool{
        switch size {
        case .small:
            width = 20
            height = 10
        case .large:
            width = 100
            height = 100
        }
        return $width || $height
    }
}

//全局的变量时延迟加载的，局部变量不延迟加载

//类型属性：所有实例共享的属性，有点像OC中的类属性、全局静态量
//1.类型属性有存储类型属性、计算类型属性，计算型类型属性跟实例的计算型属性一样只能定义成变量属性
//2.类型属性必须设定一个初始值
//3.存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。
//4.使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写
//5.类型属性通过类进行点语法访问
struct StaticPropertyStruct {
    static let t = "StaticPropertyStruct"
    static var one: Int {
        return 1
    }
}

enum StaticPropertyEnum {
    static let t = "StaticPropertyEnum"
    static var six: Int{
        return 6
    }
}

class StaticPropertyClass {
    static let t = "StaticPropertyClass"
    static var five: Int {
        5
    }
    class var overrideableComputedTypeProperty: Int {
        32
    }
}

func classPropertyUsage() {
    print(StaticPropertyStruct.t,StaticPropertyEnum.t,StaticPropertyClass.t)
}

struct AudioChannel {
    //声道阀值
    static let thresholdLevel = 10
    //记录所有的声道的最大输入值
    static var maxInputValueForAllChannel = 0
    
    var currentLevel = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputValueForAllChannel {
                AudioChannel.maxInputValueForAllChannel = currentLevel
            }
            
        }
    }
    
}
