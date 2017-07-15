import Foundation

public struct Look<T> {
    
    let object: T
}

public protocol Alterable: class {
    
    associatedtype AlterType
    
    var look: Look<AlterType> { get }
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
    func prepare(style: AnyHashable, change: @escaping Change<T>) -> Look<T> {
        object.styles[style] = change
        guard style == object.style else { return self }
        object.style = style
        return self
    }
    
    @discardableResult
    func prepare(styles: AnyHashable..., change: @escaping Change<T>) -> Look<T> {
        for style in styles {
            object.styles[style] = change
            guard style == object.style else { continue }
            object.style = style
        }
        return self
    }
    
    var style: AnyHashable? {
        get {
            return object.style
        }
        set(value) {
            object.style = value
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
    }
}

struct LookFrameworkRuntimeKeys {
    
    static var style = "\(#file)+\(#line)"
    static var styles = "\(#file)+\(#line)"
}

extension Alterable {
    
    var style: AnyHashable? {
        get {
            return objc_getAssociatedObject(self, &LookFrameworkRuntimeKeys.style) as? AnyHashable
        }
        set(value) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &LookFrameworkRuntimeKeys.style, value, policy)
            guard let value = value else { return }
            guard let change = styles[value] else { return }
            look.apply(change)
        }
    }
    
    var styles: [AnyHashable:Change<Self>] {
        get {
            return objc_getAssociatedObject(self, &LookFrameworkRuntimeKeys.styles) as? [AnyHashable:Change<Self>] ?? [:]
        }
        set(value) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &LookFrameworkRuntimeKeys.styles, value, policy)
        }
    }
}
