
// NOT ORIGINAL CODE: Credit goes to Nate Cook (08/30/2014, http://natecook.com)
// http://stackoverflow.com/questions/25575513/what-protocol-should-be-adopted-by-a-type-for-a-generic-function-to-take-any-num

/**
 *  Numeric type implements basic arithmetic operations.
 */
public protocol NumericType {
    func +(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
    func %(lhs: Self, rhs: Self) -> Self
    
    init(_ v: Int)
}

// Surprise, surprise.
// There are already many numeric types in Swift's standard library.

extension Double : NumericType { }
extension Float  : NumericType { }
extension Int    : NumericType { }
extension Int8   : NumericType { }
extension Int16  : NumericType { }
extension Int32  : NumericType { }
extension Int64  : NumericType { }
extension UInt   : NumericType { }
extension UInt8  : NumericType { }
extension UInt16 : NumericType { }
extension UInt32 : NumericType { }
extension UInt64 : NumericType { }
