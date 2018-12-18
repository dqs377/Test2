import UIKit

/// question: 1
let dic = [["name": "zhangsan", "age": 18], ["name": "lisi", "age": 19], ["name": "wangwu", "age": 20]]

let str = dic.map( { $0["name"]! } )  //返回字典数组中每个字典元素的"name"对应的值
print(str)  //输出["zhangsan", "lisi", "wangwu"]


/// question: 2
let arr1 = ["ajsfhu", "182has8f", "187326478", "123"]
let arr2 = arr1.filter( { Int($0) != nil } )  //先将字符串元素强转为Int?，如果值为nil，则表示该字符串不能转换成Int
print(arr2)  //输出["187326478", "123"]


/// question: 3
let arr3 = ["ajsfhu", "182has8f", "187326478"]
var str1 = arr3.reduce("", { $0 + "," + $1 }) //将字符串数组整合
str1.remove(at: str1.startIndex)  //因为整合结果的字符串的第一个字符为","，所以需要将这个","移除
print(str1)  //输出ajsfhu,182has8f,187326478


/// question: 4
let tuple = intArr.reduce((max: intArr[0], min: intArr[0], sum: 0), { (max: max($0.max, $1), min: min($0.min, $1), $0.sum + $1) })
print(tuple)  //输出(44, 11, 99)


/// question: 5
func f1(a: Int) -> Int {
    return a
}  //函数类型为(Int) -> Int

func f2(a: String) -> Int {
    return Int(a)!
}  //函数类型为(String) -> Int

func f3() -> Int {
    return 2
}  //函数类型为() -> Int

func f4(a: Int) {
    
}  //函数类型为(Int) -> Void

func f5(a: Int) -> Int {
    return a + 1
}  //函数类型为(Int) -> Int

let funArr: [Any] = [f1, f2, f3, f4, f5]
for (index, value) in funArr.enumerated() { //因为循环过程中需要设计到数组的下标，要将数组元素一一列举出来，所以需要调用数组的enumerated()方法。
    if value is (Int) -> Int {
        print(index)  //输出类型为(Int) -> Int的函数在数组中的下标，
    }
}  //输出结果为0 (换行)  4


/// question: 6
extension Int {
    //因为直接使用系统的sqrt(Double)函数会与扩展中定义的函数冲突，所以需要指定系统函数的框架
    
    /// 求平方根
    ///
    /// - Returns: 返回该Int型数据的平方根
    func sqrt() -> Double {
        return Darwin.sqrt(Double(self))
    }
}

print(4.sqrt())  //输出2.0


/// question: 7
//自定义泛型函数，因为需要比较大小，所以该泛型需要遵循Comparable协议，函数参数为可变参数

/// 返回参数中的最大值和最小值
///
/// - Parameter a: 一组可以直接比较大小的值
/// - Returns: 返回一个元组，第一个值为最大值，第二个值为最小值
func getMaxAndMin<T: Comparable>(a: T...) -> (T, T) {
    var max = a[0]
    var min = a[0]
    
    for item in a {
        if item > max {
            max = item
        } else if item < min {
            min = item
        }
    }
    
    return (max, min)
}

print(getMaxAndMin(a: 1, 2, 3, 9, 2, 88))  //输出(88, 1)
print(getMaxAndMin(a: 1.0, 2.0, 3.0, 9.0, 2.0, 88.0))  //输出(88.0, 1.0)
print(getMaxAndMin(a: "a", "b", "A", "sss"))  //输出("sss", "A")


·作业2：

//性别的枚举
enum Gender: Int {
    case male    //男性
    case female  //女性
    case unknow  //未知
    
    //重载>操作符，方便后面排序使用
    static func >(lhs: Gender, rhs: Gender) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}1234567891011

定义Department枚举



//公寓的枚举
enum Department {
    case one, two, three
}1234

定义SchoolProtocol协议



//学校协议
protocol SchoolProtocol {
    var department: Department { get set }
    func lendBook()
}12345

//定义Person类并实例化



//人类
class Person: CustomStringConvertible  {
    var firstName: String  //姓
    var lastName: String  //名
    var age: Int  //年龄
    var gender: Gender  //性别
    
    var fullName: String {  //全名
        get {
            return firstName + lastName
        }
    }
    
    //构造方法
    init(firstName: String, lastName: String, age: Int, gender: Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    
    convenience init(firstName: String, age: Int, gender: Gender) {
        self.init(firstName: firstName, lastName: "", age: age, gender: gender)
    }
    
    convenience init(firstName: String) {
        self.init(firstName: firstName, age: 0, gender: Gender.unknow)
    }
    
    required convenience init() {
        self.init(firstName: "")
    }
    
    //重载==
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.fullName == rhs.fullName && lhs.age == rhs.age && lhs.gender == rhs.gender
    }
    
    //重载!=
    static func !=(lhs: Person, rhs: Person) -> Bool {
        return !(lhs == rhs)
    }
    
    //实现CustomStringConvertible协议中的计算属性，可以使用print直接输出对象内容
    var description: String {
        return "fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
    
    //输出Person XXX is running
    func run() {
        print("Person \(self.fullName) is running")
    }
}

var p1 = Person(firstName: "张")
var p2 = Person(firstName: "张", age: 20, gender: .male)
print(p1)  //输出fullName: 张, age: 0, gender: male
print(p1 == p2)  //输出false
print(p1 != p2)  //输出true1234567891011121314151617181920212223242526272829303132333435363738394041424344454647484950515253545556575859

//定义Teacher类并实例化



//教师类
class Teacher: Person, SchoolProtocol {
    var title: String  //标题
    var department: Department  //公寓
    
    //构造方法
    init(title: String, firstName: String, lastName: String, age: Int, gender: Gender, department: Department) {
        self.title = title
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    init(title: String, department: Department) {
        self.title = title
        self.department = department
        super.init(firstName: "", lastName: "", age: 0, gender: .unknow)
    }
    
    convenience required init() {
        self.init(title: "", department: Department.one)
    }
    
    //重写父类的计算属性
    override var description: String {
        return "title: \(self.title), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender), department: \(self.department)"
    }
    
    //重载父类run方法
    override func run() {
        print("Teacher \(self.fullName) is running")
    }
    
    //遵循协议的方法
    func lendBook() {
        print("Teacher \(self.fullName) lend a book")
    }
}

var t1 = Teacher(title: "hello", department: .one)
print(t1)  //输出title: hello, fullName: , age: 0, gender: unknow, department: one12345678910111213141516171819202122232425262728293031323334353637383940

//定义Student类并实例化



//学生类
class Student: Person, SchoolProtocol {
    var stuNo: Int  //学号
    var department: Department  //公寓
    
    //构造方法
    init(stuNo: Int, firstName: String, lastName: String, age: Int, gender: Gender, department: Department) {
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    init(stuNo: Int, department: Department) {
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: "", lastName: "", age: 0, gender: Gender.unknow)
    }
    
    required convenience init() {
        self.init(stuNo: 0, department: .one)
    }
    
    //重写父类的计算属性
    override var description: String {
        return "stuNo: \(self.stuNo), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender), department: \(self.department)"
    }
    
    //重载父类run方法
    override func run() {
        print("Student \(self.fullName) is running")
    }
    
    //遵循协议的方法
    func lendBook() {
        print("Teacher \(self.fullName) lend a book")
    }
}

var s1 = Student(stuNo: 2015110101, department: .two)
print(s1)  //输出stuNo: 2015110101, fullName: , age: 0, gender: unknow, department: two12345678910111213141516171819202122232425262728293031323334353637383940

//对数组执行操作



//初始化一个空的Person数组
var array = [Person]()

//生成5个Person对象
for i in 1...5 {
    let temp = Person(firstName: "张", lastName: "\(i)", age: 20, gender: .male)
    array.append(temp)
}
//生成3个Teacher对象
for i in 1...3 {
    let temp = Teacher(title: "hello", firstName: "李", lastName: "\(i)", age: 21, gender: .female, department: .one)
    array.append(temp)
}
//生成4个Student对象
for i in 1..<5 {
    let temp = Student(stuNo: 2015110100 + i, firstName: "王", lastName: "\(i)", age: 19, gender: .male, department: .two)
    array.append(temp)
}

//定义一个字典，用于统计每个类的对象个数
var dict = ["Person": 0, "Teacher": 0, "Student": 0]

for item in array {
    if item is Teacher {  //是否是Teacher类
        dict["Teacher"]! += 1
    } else if item is Student {  //是否是Student
        dict["Student"]! += 1
    } else {  //Person类
        dict["Person"]! += 1
    }
}

//输出字典值
for (key, value) in dict {
    print("\(key) has \(value) items")
}

//原始数组
print("------------------------------")
for item in array {
    print(item)
}

//根据age从大到小排序
print("------------------------------")
array.sort { return $0.age > $1.age}
for item in array {
    print(item)
}

//根据全名从前往后排序
print("------------------------------")
array.sort { return $0.fullName < $1.fullName}
for item in array {
    print(item)
}

//根据gender和age从大往小排序
print("------------------------------")
array.sort { return ($0.gender > $1.gender) && ($0.age > $1.age) }
for item in array {
    print(item)
}

//穷举，调用run方法和lendBook方法
print("------------------------------")
for item in array {
    item.run()
    if let teacher = item as? Teacher {
        teacher.lendBook()
    } else if let student = item as? Student {
        student.lendBook()
}

