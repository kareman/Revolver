import Foundation

class Simulation {
    
    private typealias ShellResult = (exitCode: Int32, output: String)
    
    private static func shell(executable: String, args: String...) -> ShellResult {
        // Courtesy of StackOverflow.
        // http://stackoverflow.com/questions/26971240/how-do-i-run-an-terminal-command-in-a-swift-script-e-g-xcodebuild
        
        let task = NSTask()
        task.launchPath = executable
        task.arguments = args
        
        let stderr = NSPipe()
        task.standardError = stderr
        
        let stdout = NSPipe()
        task.standardOutput = stdout
        
        task.launch()
        task.waitUntilExit()
        
        if task.terminationStatus != 0 {
            let debugData = Simulation.readPipe(stderr)
            print("      - stderr: \(debugData)")
        }
        
        return (exitCode: task.terminationStatus, output: Simulation.readPipe(stdout))
    }
    
    private static func readPipe(pipe: NSPipe) -> String {
        let outdata = pipe.fileHandleForReading.readDataToEndOfFile()
        var output = ""
        if let string = String.fromCString(UnsafePointer(outdata.bytes)) {
            output = string.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        }
        
        return output
    }
    
    private let app: String
    
    init() {
        self.app = NSBundle.mainBundle().pathForResource("qwopper", ofType: "jar")!
    }
    
    func testChromosome(chromosome: QwopChromosome, tries: Int, time: NSTimeInterval) -> Double {
        let progString = chromosome.programString
        let timeInt = Int(time * 1000.0)
        
        for _ in 1...3 {
            print("      - try 1")
            let out = Simulation.shell("/usr/bin/java", args: "-jar", app, "\(tries)", "\(timeInt)", progString)
            
            if out.exitCode == 0 {
                // Simulation succeeded.
                let distances = out.output.componentsSeparatedByString("\n").map(parseLine).filter { $0 != nil }.map { !$0!.success ? 0 : $0!.distance }
                let meanDistance = distances.count == 0 ? 0 : distances.reduce(0, combine: +) / Double(distances.count)
                let maxDistance = Double(100) // meters
                
                // The fitness function is fraction of total distance (100m) traveled in constant time interval (or until crash).
                return min(1, max(0, meanDistance / maxDistance))
            }
        }
        
        // 3 simulation errors in a row. Give up.
        return 0
    }
    
    private typealias RunInfo = (success: Bool, duration: Int, distance: Double)
    private func parseLine(line: String) -> RunInfo? {
        let components = line.componentsSeparatedByString(";")
        guard components.count == 3 else { return nil }
        
        let success = components[0] == "1"
        let maybeDuration = Int(components[1])
        
        let normalizedDistance = components[2].stringByReplacingOccurrencesOfString(",", withString: ".")
        let maybeDistance = Double(normalizedDistance)
        
        guard let duration = maybeDuration, distance = maybeDistance else { return nil }        
        return (success: success, duration: duration, distance: distance)
    }
    
}
