
/**
 *  Objects with fitness value, most likely individuals.
 */
public protocol FitnessType {
    
    /// Floating-point value between 0 (unfit) and 1 (perfectly fit).
    var fitness: Double? { get }
    
}
