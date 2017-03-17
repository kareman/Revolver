
struct CSVParser {
    
    fileprivate init() { }
    
    // This method parses David Pisinger's CSV format for knapsack instances.
    static func parseCSV(_ path: String) -> [ProblemInstance] {
        guard let reader = StreamReader(path: path) else {
            print("ERROR: Could not read file at path \(path)")
            return []
        }
        
        defer {
            reader.close()
        }
        
        var instances = [ProblemInstance]()
        
        var lookingForThings = false
        var currentCapacity: Int?
        var currentThings: [Thing]?
        var currentOptimum: [Bool]?
        
        while let line = reader.nextLine() {
            if lookingForThings {
                if line.hasPrefix("--") {
                    // End of the instance.
                    
                    instances.append(ProblemInstance(
                        capacity: Double(currentCapacity!),
                        things: currentThings!,
                        optimalSolution: KnapsackChromosome(array: currentOptimum!)
                    ))
                    
                    lookingForThings = false
                    currentThings = nil
                    currentOptimum = nil
                    currentCapacity = nil
                } else if line.hasPrefix("z ") || line.hasPrefix("time ") {
                    // Skip the line.
                    
                    continue
                } else {
                    // Add a thing.
                    
                    let components = line.components(separatedBy: ",")
                    guard components.count == 4 else {
                        print("WARNING: Expected 4 tokens on the row: \(line)")
                        continue
                    }
                    
                    guard let value = Int(components[1]),
                        let size = Int(components[2]),
                        let optimal = Int(components[3]) else {
                            print("WARNING: Expected tokens of integer types on the row: \(line)")
                            continue
                    }
                    
                    currentThings?.append(Thing(size: Double(size), value: Double(value)))
                    currentOptimum?.append(optimal != 0)
                }
            } else if line.hasPrefix("c ") {
                // New problem instance.
                
                let components = line.components(separatedBy: " ")
                guard components.count >= 2 else {
                    print("WARNING: Expected 2 tokens on the row: \(line)")
                    continue
                }
                guard let capacity = Int(components[1]) else {
                    print("WARNING: Expected 2nd token of integer type on the row: \(line)")
                    continue
                }
                
                currentCapacity = capacity
                currentThings = []
                currentOptimum = []
                lookingForThings = true
            }
        }
        
        return instances
    }
    
}
