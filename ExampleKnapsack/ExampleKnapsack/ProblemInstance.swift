
struct ProblemInstance {
    
    // Problem instance provided by Florida State University
    // https://people.sc.fsu.edu/~jburkardt/datasets/knapsack_01/knapsack_01.html
    static let capacity = Double(165)
    static let things = [
        Thing(size: 23, value: 92),
        Thing(size: 31, value: 57),
        Thing(size: 29, value: 49),
        Thing(size: 44, value: 68),
        Thing(size: 53, value: 60),
        Thing(size: 38, value: 43),
        Thing(size: 63, value: 67),
        Thing(size: 85, value: 84),
        Thing(size: 89, value: 87),
        Thing(size: 82, value: 72)
    ]
    
    // Note that the optimal solution is:
    // 1111010000 (weight: 309, fitness: 0.455)
    static let optimalSolution = KnapsackChromosome(array: [
        true,
        true,
        true,
        true,
        false,
        true,
        false,
        false,
        false,
        false
    ])
    
    private init() {}
    
}
