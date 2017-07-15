import Foundation

// MARK: - Look

public struct Look<T> {
    
    let object: T
}

// MARK: - Alterable

public protocol Alterable: class {
    
    associatedtype AlterType
    
    var look: Look<AlterType> { get set }
}

extension NSObject: Alterable {}

// MARK: - Change

public typealias Change<T> = (T) -> Void

// MARK: -

extension Alterable {
    
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
    static func +(look: Look, change: @escaping Change<T>) -> Look<T> {
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
    
    subscript(styles: AnyHashable...) -> Change<T>? {
        get {
            guard let style = styles.first, styles.count == 1 else { return nil }
            return object.styles[style]
        }
        set(value) {
            for style in styles {
                object.styles[style] = value
                guard style == object.style else { continue }
                object.style = style
            }
        }
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
        set(value) {
            //
        }
    }
}

struct AlterableRuntimeKeys {
    
    static var style = "\(#file)+\(#line)"
    static var styles = "\(#file)+\(#line)"
}

extension Alterable {
    
    var style: AnyHashable? {
        get {
            return objc_getAssociatedObject(self, &AlterableRuntimeKeys.style) as? AnyHashable
        }
        set(value) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &AlterableRuntimeKeys.style, value, policy)
            guard let value = value else { return }
            guard let change = styles[value] else { return }
            look.apply(change)
        }
    }
    
    var styles: [AnyHashable:Change<Self>] {
        get {
            return objc_getAssociatedObject(self, &AlterableRuntimeKeys.styles) as? [AnyHashable:Change<Self>] ?? [:]
        }
        set(value) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &AlterableRuntimeKeys.styles, value, policy)
        }
    }
}
