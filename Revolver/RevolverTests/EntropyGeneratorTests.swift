import XCTest
@testable import Revolver

class EntropyGeneratorTests: XCTestCase {
    
    var generators = [EntropyGenerator]()
    
    override func setUp() {
        super.setUp()
        generators = [
            MersenneTwister(seed: 0),
            MersenneTwister(seed: 1),
            MersenneTwister(seed: 1234),
            MersenneTwister(seed: 4242),
            ArcGenerator(),
            DrandGenerator()
        ]
    }
    
    override func tearDown() {
        generators = []
        super.tearDown()
    }
    
    func testDoubleGeneration() {
        for generator in generators {
            for _ in 1...100 {
                let randomValue: Double = generator.next()
                
                XCTAssertGreaterThanOrEqual(randomValue, 0)
                XCTAssertLessThanOrEqual(randomValue, 1)
            }
        }
    }
    
    func testTightDoubleRangeGeneration() {
        let val = 42
        
        for generator in generators {
            for _ in 1...100 {
                let randomValue1: Double = generator.nextInRange(Range(val...val))
                let randomValue2: Double = generator.nextInRange(min: Double(val), max: Double(val))
                
                XCTAssertEqualWithAccuracy(randomValue1, Double(val), accuracy: 1e-5)
                XCTAssertEqualWithAccuracy(randomValue2, Double(val), accuracy: 1e-5)
            }
        }
    }
    
    func testValidDoubleRangeGeneration() {
        let min = 39
        let max = 47
        
        for generator in generators {
            for _ in 1...100 {
                let randomValue1: Double = generator.nextInRange(Range(min...max))
                let randomValue2: Double = generator.nextInRange(min: Double(min), max: Double(max))
                
                XCTAssertGreaterThanOrEqual(randomValue1, Double(min))
                XCTAssertLessThanOrEqual(randomValue1, Double(max))
                
                XCTAssertGreaterThanOrEqual(randomValue2, Double(min))
                XCTAssertLessThanOrEqual(randomValue2, Double(max))
            }
        }
    }
    
    func testTightIntRangeGeneration() {
        let val = 4894
        
        for generator in generators {
            for _ in 1...100 {
                let randomValue1: Int = generator.nextInRange(Range(val...val))
                let randomValue2: Int = generator.nextInRange(min: val, max: val)
                
                XCTAssertEqual(randomValue1, val)
                XCTAssertEqual(randomValue2, val)
            }
        }
    }
    
    func testValidIntRangeGeneration() {
        let min = 14596
        let max = 15683
        
        for generator in generators {
            for _ in 1...100 {
                let randomValue1: Int = generator.nextInRange(Range(min...max))
                let randomValue2: Int = generator.nextInRange(min: min, max: max)
                
                XCTAssertGreaterThanOrEqual(randomValue1, min)
                XCTAssertLessThanOrEqual(randomValue1, max)
                
                XCTAssertGreaterThanOrEqual(randomValue2, min)
                XCTAssertLessThanOrEqual(randomValue2, max)
            }
        }
    }
    
}
