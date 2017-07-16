import Foundation

public struct Look<T> {
    
    let object: T
}

public protocol Alterable: class {
    
    associatedtype AlterType
    
    var look: Look<AlterType> { get set }
}

extension NSObject: Alterable {}

public typealias Change<T> = (T) -> Void

public extension Alterable {
    
    static func change(closure: @escaping Change<Self>) -> Change<Self> {
        return closure
    }
}

public extension Look where T: Alterable {
    
    @discardableResult
    func apply(_ changes: Change<T>...) -> Look<T> {
        changes.forEach { (change) in
            change(object)
        }
        return self
    }
    
    @discardableResult
    static func +(look: Look<T>, change: @escaping Change<T>) -> Look<T> {
        look.apply(change)
        return look
    }
    
    @discardableResult
    func prepare(state: AnyHashable, change: @escaping Change<T>) -> Look<T> {
        object.states[state] = change
        guard state == object.state else { return self }
        object.state = state
        return self
    }
    
    @discardableResult
    func prepare(states: AnyHashable..., change: @escaping Change<T>) -> Look<T> {
        for state in states {
            object.states[state] = change
            guard state == object.state else { continue }
            object.state = state
        }
        return self
    }
    
    var state: AnyHashable? {
        get {
            return object.state
        }
        set(value) {
            object.state = value
        }
    }
}

public func +<T:Alterable>(lhs: @escaping Change<T>, rhs: @escaping Change<T>) -> Change<T> {
    return { (value: T) -> Void in
        lhs(value)
        rhs(value)
    }
}

public extension Alterable {
    
    var look: Look<Self> {
        get {
            return Look(object: self)
        }
        set {
            //
        }
    }
}

struct LookFrameworkRuntimeKeys {
    
    static var state = "\(#file)+\(#line)"
    static var states = "\(#file)+\(#line)"
}

extension Alterable {
    
    var state: AnyHashable? {
        get {
            return objc_getAssociatedObject(self, &LookFrameworkRuntimeKeys.state) as? AnyHashable
        }
        set(value) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &LookFrameworkRuntimeKeys.state, value, policy)
            guard let value = value else { return }
            guard let change = states[value] else { return }
            look.apply(change)
        }
    }
    
    var states: [AnyHashable:Change<Self>] {
        get {
            return objc_getAssociatedObject(self, &LookFrameworkRuntimeKeys.states) as? [AnyHashable:Change<Self>] ?? [:]
        }
        set(value) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &LookFrameworkRuntimeKeys.states, value, policy)
        }
    }
}
