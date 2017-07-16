[![Version](https://img.shields.io/cocoapods/v/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![License](https://img.shields.io/cocoapods/l/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![Platform](https://img.shields.io/cocoapods/p/Look.svg?style=flat)](http://cocoapods.org/pods/Look)

* [Look](#look)
* [Customizing objects with closures](#customizing-objects-with-closures)
   * [Changes](#changes)
   * [Combine changes](#combine-changes)
   * [Apply changes](#apply-changes)
* [States](#states)
   * [Predefined changes](#predefined-changes)
   * [Delayed preparation](#delayed-preparation)
* [Installation](#installation)
* [Author](#author)
* [License](#license)

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
[Look](#look) should be used to apply objects' [changes](#changes) and [states](#states).

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

`Look` framework introduces a generic typealias which describes such closures
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

## States

[State](#states) is a new parameter of an object that is introduced by `Look` framework and can be accessed only through [look](#look) structure
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
    view.layer.borderColor = UIColor.black.cgColor
}
let changeEnabled = UIView.change { (view) in
    view.alpha = 1.0
    view.layer.borderColor = UIColor.red.cgColor
}
```
These changes can be predefined with some names
```ruby
view.look.prepare(states: "disabled", "initial", change: changeDisabled)
view.look.prepare(state: "enabled", change: changeEnabled)
```
and applied by changing object's [state](#states)
```ruby
view.look.state = "disabled"
```

### Delayed preparation

Sometimes, object's [state](#states) is defined before the state's [change](#changes) is prepared
```ruby
view.look.state = "some state"
view.look.prepare(state: "some state", change: someChange)
```
In such cases a [change](#changes) would be applied to an object during preparation and there is no need update object's state.

## Installation

`Look` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Look', '0.1.2'
```

## Author

izhs@protonmail.com

## License

`Look` is available under the MIT license. See the LICENSE file for more info.
