# Look

[![CI Status](http://img.shields.io/travis/izhs/Look.svg?style=flat)](https://travis-ci.org/izhs/Look)
[![Version](https://img.shields.io/cocoapods/v/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![License](https://img.shields.io/cocoapods/l/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![Platform](https://img.shields.io/cocoapods/p/Look.svg?style=flat)](http://cocoapods.org/pods/Look)

- [Look](#look)
- [Change](#change)

## Look

`Look` is a generic structure that can be accessed from each object
```ruby
let view = UIView()
let look: Look<UIView> = view.look
```
It can be used to apply [Changes](#change) and change `Styles` of an object.

## Change

It is very convenient to define object's parameters using closures.
```ruby
let change: (UIView) -> Void = { (view: UIView) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.white
}
```
And apply them to an object when necessary.
```ruby
let view = UIView()
change(view)
```
Framework introduces a typealias which describes such closures.
```ruby
Change<T> = (T) -> Void
```
Also, it introduces a generic static function that helps to construct `Changes`.
```ruby
let change = UIView.change { (view) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.white
}
```
Combine `Changes` using `+` operator.
```ruby
let changeAlpha = UIView.change { (view) in
    view.alpha = 0.5
}
let changeColor = UIView.change { (view) in
    view.backgroundColor = UIColor.white
}
let change = changeAlpha + changeColor
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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
