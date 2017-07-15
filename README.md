[![CI Status](http://img.shields.io/travis/izhs/Look.svg?style=flat)](https://travis-ci.org/izhs/Look)
[![Version](https://img.shields.io/cocoapods/v/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![License](https://img.shields.io/cocoapods/l/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![Platform](https://img.shields.io/cocoapods/p/Look.svg?style=flat)](http://cocoapods.org/pods/Look)

* [Look](#look)
* [Defining parameters with closures](#defining-parameters-with-closures)
   * [Changes](#changes)
   * [Combine changes](#combine-changes)
* [Style](#style)

## Look

[Look](#look) is a generic structure with a reference to an object
```ruby
struct Look<T> {
    let object: T
}
```
that can be accessed from any object.
```ruby
let view = UIView()
let look: Look<UIView> = view.look
```
[Look](#look) should be used to apply [Changes](#changes) and change [Styles](#style) of an object.

## Defining parameters with closures

It is very convenient to define objects' parameters using closures
```ruby
let change: (UIView) -> Void = { (view: UIView) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.white
}
```
and apply them to an object when necessary.
```ruby
let view = UIView()
change(view)
```

### Changes

Framework introduces a typealias which describes such closures
```ruby
Change<T> = (T) -> Void
```
and a generic static function that helps to construct [Changes](#changes).
```ruby
let change = UIView.change { (view) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.white
}
```

### Combine changes

Combine [Changes](#changes) using `+` operator.
```ruby
let changeAlpha = UIView.change { (view) in
    view.alpha = 0.5
}
let changeColor = UIView.change { (view) in
    view.backgroundColor = UIColor.white
}
let change = changeAlpha + changeColor
```

## Style

## Requirements

## Installation

`Look` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Look', '0.1.0'
```

## Author

izhs@protonmail.com

## License

`Look` is available under the MIT license. See the LICENSE file for more info.
