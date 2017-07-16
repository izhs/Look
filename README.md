[![CI Status](http://img.shields.io/travis/izhs/Look.svg?style=flat)](https://travis-ci.org/izhs/Look)
[![Version](https://img.shields.io/cocoapods/v/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![License](https://img.shields.io/cocoapods/l/Look.svg?style=flat)](http://cocoapods.org/pods/Look)
[![Platform](https://img.shields.io/cocoapods/p/Look.svg?style=flat)](http://cocoapods.org/pods/Look)

* [Look](#look)
* [Defining parameters with closures](#defining-parameters-with-closures)
   * [Changes](#changes)
   * [Combine changes](#combine-changes)
   * [Apply changes](#apply-changes)
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
[Look](#look) should be used to apply [changes](#changes) and change [styles](#style) of an object.

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
and a generic static function that helps to construct [changes](#changes).
```ruby
let change = UIView.change { (view) in
    view.alpha = 0.5
    view.backgroundColor = UIColor.white
}
```

### Combine changes

[Changes](#changes) can be combined using `+` operator
```ruby
let changeAlpha = UIView.change { (view) in
    view.alpha = 0.5
}
let changeText = UILabel.change { (view) in
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

Using `apply` function
```ruby
view.look.apply(changeAlpha).apply(changeColor)
```

Using `+` operator
```ruby
view.look + changeAlpha + changeColor
```


## Style

## Requirements

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
