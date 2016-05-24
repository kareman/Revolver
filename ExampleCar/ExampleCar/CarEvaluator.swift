import Revolver

class CarEvaluator: SequentialEvaluator<CarChromosome> {
    
    static let maxDuration = NSTimeInterval(60 * 60) // 1 hour
    static let maxDistance = CarSimulation.maxVelocity * CarEvaluator.maxDuration
    static let attempts = 5
    
    let generator = MersenneTwister(seed: 4242)
    let sim = CarSimulation()
    
    override func evaluateChromosome(chromosome: CarChromosome) -> Fitness {
        sim.reset()
        sim.controlProgram = NetDriver(net: chromosome.toFFNN())
        
        var sumDistance = Double(0)
        
        for _ in 1...CarEvaluator.attempts {
            sim.randomizeTrack(generator)
            sim.randomizeCar(generator)
            
            let outcome = sim.run(maxDuration: CarEvaluator.maxDuration)
            sumDistance += outcome.distanceTraveledOnTrack
        }
        
        return Fitness(sumDistance / (Double(CarEvaluator.attempts) * CarEvaluator.maxDistance))
    }
    
}
