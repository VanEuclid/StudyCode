/* Chapter 2
 
let first = "Ryan"
let last = "Isham"
let bf = "\(first) \(last)"
print("\(first) \(last)")
var age = 25
print(bf)
print(age)
-100
0.5
-234.99
true
false

let gradeAvg = 2.9
let version:Float = 1.1
let isConstant:Bool = true

let sum = 23 + 20
let divide = sum / 10
let divide2 = Double(sum)/10

func greet(name:String) {
    print("Hello \(name)")
}

greet(name:"Ryan")

func greet(first:String, last:String) {
    print("Hello \(first) \(last)")
}

greet(first:"Ryan", last:"Isham")

func greeting(first:String, last:String) -> String {
    return ("Welcome \(first) \(last)")
}

print(greeting(first: "Van", last: "Dy"))

func advance(first:String, last:String, age:Int) -> String {
    return("Hello Mr \(first) \(last) and your age is \(age * 2) ")
}

print(advance(first: "Van", last: "Dy", age: 31))

for index in (10..<20).reversed() {
    print("reversed range - \(index)")
}

*/

/* Chapter 3 -> 4
 
let restaurant = false
 
if restaurant {
    print("restaurant is found!!")
} else {
    print("restaurant was not found...")
}

let names = ["Craig", "Teena", "Jason", "Joshua", "Myah", "Tiffany",
"Kim", "Veronica", "Mikka(KK)", "Milan", "Shelby", "Kaysey"]

for name in names[...6] {
    print(name)
}

var y = 0

while y < 50 {
    y += 5
    print("y:\(y)")
}

while y < 50 {
    y += 5
    print("y:\(y)")
}

var x = 0

repeat {
    x += 5
    print("x: \(x)")
} while x < 100

print("repeat completed x: \(x)")

repeat {
    x += 5
    print("x: \(x)")
} while x < 100

*/



let integers:[Int] = []
let strings = [String]()
let integers2 = [54, 29]
var states:[String] = []

states.append("Florida")
states.append(contentsOf: ["California", "New York"])

states.insert("Ohio", at:1)
states.insert(contentsOf:["North Carolina", "South Carolina", "Nevada"], at:3)

states += ["Texas", "Colorado"]
states.count

if states.isEmpty{
    print("empty")
} else {
    print("there is \(states.count) shits in this array")
}

let state = states[3-1]

if let index = states.firstIndex(of:"South Carolina") {
    print("index position is \(index)")
    states[index] = "Arizona"
    states[index]
}

let updatedStates = states.removeFirst()
states.remove(at: 2)
states.remove(at: 4)

states.removeAll()

for state in states {
    print(state)
}

let dictFirst = Dictionary<String, String>()
let dictSecond = [String: Int]()

var dictThird = Dictionary<String, Double>(dictionaryLiteral: ("veggie", 14.99), ("meat", 16.99))

var dictPizzas = ["veggie": 14.99]
dictPizzas["meat"] = 17.99
dictPizzas["meat"] = 16.99

if let oldValue = dictPizzas.updateValue(15.99, forKey: "meat") {
    print("old value is \(oldValue)")
}

dictPizzas["specialty"] = 18.99
dictPizzas["chicken"] = 16.99

if let chickenPrice = dictPizzas["chicken"] {
    print(chickenPrice)
}

for value in dictPizzas.values {
    print(value)
}

for key in dictPizzas.keys {
    print(key)
}

for (key, value) in dictPizzas {
    print("\(key): \(value)")
}

print(dictPizzas.count)

dictPizzas.removeValue(forKey: "chicken")
dictPizzas["meat"] = nil

if dictPizzas.isEmpty {
    print("there are no pizzas")
} else {
    print("there are \(dictPizzas.count) pizzas")
}

let movieSet = Set<String>()
let numberSet = Set<Int>([])

var craigsFavMovieSet = Set<String>([])
var gabesFavMovieSet = Set<String>(["Fight Club", "Matrix", "Evil Dead", "Big Trouble in Little China", "Aliens", "Winter Solider", "The Illusionist", "Predator"])
gabesFavMovieSet.insert("Terminator")
gabesFavMovieSet

craigsFavMovieSet = ["The Pianist", "The Shawshank Redemption", "Dark Knight", "Black Swan", "Ip Man", "The Illusionist", "The Silence of the Lambs", "Winter Solider", "Green Mile", "Se7en"]

if craigsFavMovieSet.contains("Green Mile") {
    print("Green Mile is one of Craig's favorite movies")
}

for movie in craigsFavMovieSet.sorted(){
    print("Craig's movie - \(movie)")
}

craigsFavMovieSet.intersection(gabesFavMovieSet)

craigsFavMovieSet.union(gabesFavMovieSet)
