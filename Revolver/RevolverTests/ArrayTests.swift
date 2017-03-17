import XCTest
@testable import Revolver

class ArrayTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRandomizable() {
        let generator = ArcGenerator()
        
        for _ in 1...100 {
            let randomArray: DoubleArray = generator.next()
            XCTAssertEqual(randomArray.array.count, 42)
        }
    }
    
    func testReproducible() {
        let generator = ArcGenerator()
        let randomArray: DoubleArray = generator.next()
        let reproduction = DoubleArray(array: randomArray.array)
        
        XCTAssertEqual(randomArray.array, reproduction.array)
    }
    
    func testMutable() {
        let generator = ArcGenerator()
        let randomArray: DoubleArray = generator.next()
        
        for _ in 1...1000 {
            let mutatedArray = randomArray.mutate(generator)
            XCTAssertNotEqual(randomArray.array, mutatedArray.array)
        }
    }
    
    func testOnePointCrossoverable() {
        let generator = ArcGenerator()
        let array1 = DoubleArray(array: [Double](repeating: 0, count: 42))
        let array2 = DoubleArray(array: [Double](repeating: 1, count: 42))
        
        let crossovered = array1.onePointCrossover(generator, other: array2)
        
        let ones1 = crossovered.first.array.reduce(0, +)
        let ones2 = crossovered.second.array.reduce(0, +)
        let totalOnes = ones1 + ones2
        
        XCTAssertEqualWithAccuracy(totalOnes, 42, accuracy: 1e-5)
    }
    
    func testTwoPointCrossoverable() {
        let generator = ArcGenerator()
        let array1 = DoubleArray(array: [Double](repeating: 0, count: 42))
        let array2 = DoubleArray(array: [Double](repeating: 1, count: 42))
        
        let crossovered = array1.twoPointCrossover(generator, other: array2)
        
        let ones1 = crossovered.first.array.reduce(0, +)
        let ones2 = crossovered.second.array.reduce(0, +)
        let totalOnes = ones1 + ones2
        
        XCTAssertEqualWithAccuracy(totalOnes, 42, accuracy: 1e-5)
    }
    
}
