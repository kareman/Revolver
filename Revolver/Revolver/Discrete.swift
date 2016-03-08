/**
 *  Discrete types can list all their values.
 */
public protocol Discrete {
    /// All possible values of the type. No cheating.
    static var allValues: [Self] { get }
}
