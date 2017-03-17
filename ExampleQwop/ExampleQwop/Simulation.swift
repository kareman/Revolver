import Foundation

class Simulation {
    
    fileprivate typealias ShellResult = (exitCode: Int32, output: String)
    
    fileprivate static func shell(_ executable: String, args: String...) -> ShellResult {
        // Courtesy of StackOverflow.
        // http://stackoverflow.com/questions/26971240/how-do-i-run-an-terminal-command-in-a-swift-script-e-g-xcodebuild
        
        let task = Process()
        task.launchPath = executable
        task.arguments = args
        
        let stderr = Pipe()
        task.standardError = stderr
        
        let stdout = Pipe()
        task.standardOutput = stdout
        
        task.launch()
        task.waitUntilExit()
        
        if task.terminationStatus != 0 {
            let debugData = Simulation.readPipe(stderr)
            print("      - stderr: \(debugData)")
        }
        
        return (exitCode: task.terminationStatus, output: Simulation.readPipe(stdout))
    }
    
    fileprivate static func readPipe(_ pipe: Pipe) -> String {
        let outdata = pipe.fileHandleForReading.readDataToEndOfFile()
        var output = ""
        if let string = String(data: outdata, encoding: .utf8) {
            output = string.trimmingCharacters(in: CharacterSet.newlines)
        }
        
        return output
    }
    
    fileprivate let app: String
    
    init() {
        self.app = Bundle.main.path(forResource: "qwopper", ofType: "jar")!
    }
    
    func testChromosome(_ chromosome: QwopChromosome, tries: Int, time: TimeInterval) -> Double {
        let progString: String        
        if !chromosome.programString.contains("+") {
            // Safety measure. There has to be at least one "+" or the qwopper app will hang in an infinite loop.
            progString = chromosome.programString + "+"
        } else {
            progString = chromosome.programString
        }
        
        
        let timeInt = Int(time * 1000.0)
        
        for t in 1...3 {
            print("      - try \(t)")
            let out = Simulation.shell("/usr/bin/java", args: "-jar", app, "\(tries)", "\(timeInt)", progString)
            
            if out.exitCode == 0 {
                // Simulation succeeded.
                let distances = out.output.components(separatedBy: "\n").map(parseLine).filter { $0 != nil }.map { !$0!.success ? 0 : $0!.distance }
                let meanDistance = distances.count == 0 ? 0 : distances.reduce(0, +) / Double(distances.count)
                let maxDistance = Double(100) // meters
                
                // The fitness function is fraction of total distance (100m) traveled in constant time interval (or until crash).
                return min(1, max(0, meanDistance / maxDistance))
            }
        }
        
        // 3 simulation errors in a row. Give up.
        return 0
    }
    
    fileprivate typealias RunInfo = (success: Bool, duration: Int, distance: Double)
    fileprivate func parseLine(_ line: String) -> RunInfo? {
        let components = line.components(separatedBy: ";")
        guard components.count == 3 else { return nil }
        
        let success = components[0] == "1"
        let maybeDuration = Int(components[1])
        
        let normalizedDistance = components[2].replacingOccurrences(of: ",", with: ".")
        let maybeDistance = Double(normalizedDistance)
        
        guard let duration = maybeDuration, let distance = maybeDistance else { return nil }        
        return (success: success, duration: duration, distance: distance)
    }
    
}
