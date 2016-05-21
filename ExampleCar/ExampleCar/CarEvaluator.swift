import Revolver

class CarEvaluator: SequentialEvaluator<CarChromosome> {
    static let maxDuration = NSTimeInterval(60 * 60) // 1 hour
    static let maxDistance = CarSimulation.maxVelocity * CarEvaluator.maxDuration
    static let attempts = 3
    
    let generator = MersenneTwister(seed: 4242)
    let sim = CarSimulation()
    
    override func evaluateChromosome(individual: CarChromosome) -> Fitness {
        sim.reset()
        sim.randomizeTrack(generator)
        sim.controlProgram = NetDriver(net: individual.toFFNN())
        
        var results = [Fitness]()
        results.reserveCapacity(CarEvaluator.attempts)
        for _ in 1...CarEvaluator.attempts {
            sim.randomizeCar(generator)
            
            let outcome = sim.run(maxDuration: CarEvaluator.maxDuration)
            results.append(Fitness(outcome.distanceTraveledOnTrack) / Fitness(CarEvaluator.maxDistance))
        }
        
        return results.reduce(0, combine: +) / Fitness(CarEvaluator.attempts)
    }
}
