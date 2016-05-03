
// Here is some syntax sugar for pipelines.
infix operator ---> { associativity left precedence 140 }
infix operator ||| { associativity left precedence 150 }

public func ---><Chromosome: Randomizable>(lhs: GeneticOperator<Chromosome>, rhs: GeneticOperator<Chromosome>) -> Pipeline<Chromosome> {
    let leftPipeline = GeneticOperatorPipeline(lhs)
    let rightPipeline = GeneticOperatorPipeline(rhs)
    
    leftPipeline.chain(rightPipeline)
    return leftPipeline
}

public func ---><Chromosome: Randomizable>(lhs: Pipeline<Chromosome>, rhs: GeneticOperator<Chromosome>) -> Pipeline<Chromosome> {
    let rightPipeline = GeneticOperatorPipeline(rhs)
    lhs.chain(rightPipeline)
    return lhs
}

public func ---><Chromosome: Randomizable>(lhs: Pipeline<Chromosome>, rhs: BranchingPipeline<Chromosome>) -> Pipeline<Chromosome> {
    lhs.chain(rhs)
    return lhs
}

public func ---><Chromosome: Randomizable>(lhs: BranchingPipeline<Chromosome>, rhs: Pipeline<Chromosome>) -> Pipeline<Chromosome> {
    lhs.chain(rhs)
    return lhs
}

public func |||<Chromosome: Randomizable>(lhs: Choice<Chromosome>, rhs: Choice<Chromosome>) -> BranchingPipeline<Chromosome> {
    let leftBranching = BranchingPipeline<Chromosome>()
    leftBranching.split(lhs)
    leftBranching.split(rhs)
    
    return leftBranching
}

public func |||<Chromosome: Randomizable>(lhs: BranchingPipeline<Chromosome>, rhs: Choice<Chromosome>) -> BranchingPipeline<Chromosome> {
    lhs.split(rhs)
    return lhs
}

