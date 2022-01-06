import UIKit

extension Date {
    var day: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "DD"
        return dateFormat.string(from: self)
    }
}

extension Date {
    var month: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM"
        return dateFormat.string(from: self)
    }
}

extension Date {
    var year: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "YYYY"
        return dateFormat.string(from: self)
    }
}

extension Date {
    var dateAsPrettyString: String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "DD<>MM<>YYYY"
        return dateFormat.string(from: self)
    }
}

let myDate = Date()

print(myDate.day)
print(myDate.month)
print(myDate.year)
print(myDate.dateAsPrettyString)
