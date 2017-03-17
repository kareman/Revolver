
// Here is some syntax sugar for decision trees.
infix operator ---> : AdditionPrecedence
infix operator ||| : MultiplicationPrecedence

public func ---><Chromosome: Randomizable>(lhs: GeneticOperator<Chromosome>, rhs: GeneticOperator<Chromosome>) -> DecisionTreeNode<Chromosome> {
    let leftPipeline = GeneticOperatorNode(lhs)
    let rightPipeline = GeneticOperatorNode(rhs)
    
    leftPipeline.chain(rightPipeline)
    return leftPipeline
}

public func ---><Chromosome: Randomizable>(lhs: DecisionTreeNode<Chromosome>, rhs: GeneticOperator<Chromosome>) -> DecisionTreeNode<Chromosome> {
    let rightPipeline = GeneticOperatorNode(rhs)
    lhs.chain(rightPipeline)
    return lhs
}

public func ---><Chromosome: Randomizable>(lhs: DecisionTreeNode<Chromosome>, rhs: ChanceNode<Chromosome>) -> DecisionTreeNode<Chromosome> {
    lhs.chain(rhs)
    return lhs
}

public func ---><Chromosome: Randomizable>(lhs: ChanceNode<Chromosome>, rhs: DecisionTreeNode<Chromosome>) -> DecisionTreeNode<Chromosome> {
    lhs.chain(rhs)
    return lhs
}

public func |||<Chromosome: Randomizable>(lhs: Choice<Chromosome>, rhs: Choice<Chromosome>) -> ChanceNode<Chromosome> {
    let leftBranching = ChanceNode<Chromosome>()
    leftBranching.split(lhs)
    leftBranching.split(rhs)
    
    return leftBranching
}

public func |||<Chromosome: Randomizable>(lhs: ChanceNode<Chromosome>, rhs: Choice<Chromosome>) -> ChanceNode<Chromosome> {
    lhs.split(rhs)
    return lhs
}

