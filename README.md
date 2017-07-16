[![CI Status](http://img.shields.io/travis/izhs/Look.svg?style=flat)](https://travis-ci.org/izhs/Look)
[![Version](https://img.shields.io/cocoapods/v/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![License](https://img.shields.io/cocoapods/l/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![Platform](https://img.shields.io/cocoapods/p/Look.svg?style=flat)](http://cocoapods.org/pods/Look)

* [Look](#look)
* [Customizing objects with closures](#customizing-objects-with-closures)
   * [Changes](#changes)
   * [Combine changes](#combine-changes)
   * [Apply changes](#apply-changes)
* [State](#state)
   * [Predefined changes](#predefined-changes)

## Look

[Look](#look) is a generic structure with a reference to an object
```ruby
struct Look<T> {
    let object: T
}
```
that can be accessed from any object
```ruby
let view = UIView()
let look: Look<UIView> = view.look
```
[Look](#look) should be used to apply [changes](#changes) and [states](#state) of an object.

## Customizing objects with closures

It is very convenient to define objects' parameters using closures
```ruby
let change: (UIView) -> Void = { (view: UIView) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.white
}
```
and apply them to an object when necessary
```ruby
let view = UIView()
change(view)
```

### Changes

Framework introduces a typealias which describes such closures
```ruby
Change<T> = (T) -> Void
```
and a generic static function that helps to construct [changes](#changes)
```ruby
let change = UIView.change { (view) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.white
}
```

### Combine changes

[Changes](#changes) can be combined using `+` operator
```ruby
let changeAlpha: Change<UIView> = UIView.change { (view) in
    view.alpha = 0.5
}
let changeText: Change<UILabel> = UILabel.change { (view) in
    view.text = "text"
}
let change: Change<UILabel> = changeAlpha + changeText
```

### Apply changes

There are some ways to apply changes to an object in addition to a simple way
```ruby
changeAlpha(view)
changeColor(view)
```

Using [look](#look) and `apply` function 
```ruby
view.look.apply(changeAlpha).apply(changeColor)
```

Using [look](#look) and `+` operator
```ruby
view.look + changeAlpha + changeColor
```

## State

[State](#state) is a new parameter of an object that is introduced by `Look` framework and can be accessed only through [look](#look) structure
```ruby
extension Look {
    var state: AnyHashable? { get set }
}
```
Whenever an object is changed you can also change its state in order to apply predefined [changes](#changes).

### Predefined changes
Let's imagine that we have different [changes](#changes) that should be applied to a view
```ruby
let changeDisabled = UIView.change { (view) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.gray
}
let changeEnabled = UIView.change { (view) in
    view.alpha = 1.0
    view.backgroundColor = UIColor.white
}
```
These changes can be predefined with some names
```ruby
view.look.prepare(state: "disabled", change: changeDisabled)
view.look.prepare(state: "enabled", change: changeEnabled)
```
and later applied by changing object's [state](#state)
```ruby
view.look.state = "disabled"
```

## Requirements

## Installation

`Look` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Look', '0.1.1'
```

## Author

izhs@protonmail.com

## License

`Look` is available under the MIT license. See the LICENSE file for more info.
