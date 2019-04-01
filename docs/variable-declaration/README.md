# 变量声明

和 JavaScript 一样，Dart 的变量声明也是用 `var` 关键字，但是不同于 JavaScript 的是，因为 Dart 是一种强态类型的语言，虽然在声明变量的时候不一定要指定类型，但是 **第一次赋值的类型将会默认为该变量的类型，并且声明之后，该变量的类型将不能被改变**：

```dart
var name = '大板栗';

// 下面代码在 Dart 中将会报错
// 因为变量 `name` 第一次赋值的是 String 类型
// 而类型一旦确认后，将无法再次修改
name = 🌰; // 不同的类型
```

> 有别于 JavaScript 的是 Dart 中分号 `;` 是必须的

上面的代码在 JavaScript 中运行没有问题，但是 Dart 是一种 **强类型语言**，**变量的类型一旦确定以后，将不能再次被改变**。

如果声明了一个变量但是没有赋值，那么 Dart 会给该变量一个 `null` 的初始默认值（类比 JavaScript 则是一个 `undifined` 值）：

```dart
// 被初始化为 null
// name === null
var name;
```

Dart 中的 `const` 和 `final` 两个关键字都可以用来声明一个 **常量**：

```dart
// 类型可以省略
// const String name = '大板栗';
const name = '大板栗';
// final String name = '大板栗';
final name = '大板栗';
```

> `const` 语法上和 JavaScript 可以是一致的，但表现却是不一致的，后面会提到。

既然 `const` 和 `final` 都是用来声明常量的，那么它们之间肯定是有区别的，否则没必要多此一举：

一旦某个值赋值给了由 `const` 声明的变量，那么该值将 **永远不能被改变**：

```dart
const fruits = ['apple', 'banana', 'strawberry'];
// 一旦赋值，将不能以任何方式改变其值
fruits[0] = 'pear'; // Unsupported operation: indexed set

var nums = const [1, 2, 3, 4, 5, 6];
// 尽管是用 var 关键字声明的变量
// 但是值全是用 const 关键字修饰过
// 所以下面的代码将会报错
nums[0] = 1; // Unsupported operation: indexed set

// 如果只用 var 声明，则没有此问题
var nums = [1, 2, 3, 4, 5, 6];
nums[0] = 1; // [0, 2, 3, 4, 5, 6]
```

<!-- `const` 不仅是用来定义常量的，也可以定义构造函数为 `const` 类型，被 `const` 定义的构造函数所创建的对象是 **不可变** 的：

```dart
const List fruits = ['apple', 'banana', 'strawberry'];
var fruits = const List();
``` -->

用 `final` 声明的变量只能被赋值一次：

```dart
final name = '大板栗';
// 将不能再次被赋值
// 下面代码将会报错
name = '很帅的大板栗';
```

> 熟悉 JavaScript 的同学可能会发现，Dart 中 `final` 关键字作用其实和 JavaScript 中的 `const` 的作用才是一致的，所以前面有提到 Dart 中的 `const` 和 JavaScript 中的 `const` 表现（作用）是不一致的。

除了上面几种声明变量的方式之外，`Object` 和 `dynamic` 也可以用来声明变量。和 JavaScript 一样，Dart 中的 `Object` 也是 **万物之母**，`Function`、`List`、`Null` 等类型都是它的子类，所以任何类型的值都可以赋值给 `Object` 声明的变量：

```dart
Object type = '大板栗';
// 下面的代码不会和 `var` 声明的变量一样不能再赋值别的类型而报错
type = 10086; // work
```

`dynamic` 关键字声明的变量效果和 `Object` 对象声明的效果也是一样：

```dart
dynamic type = '大板栗';
// 可以再次赋值别的类型数据
type = 10086; // work
```

## 小结

`dynamic` 和 `var` 都是以 **关键字** 的方式来声明变量，不同的是 **`dynamic` 声明的变量后续还是以赋值不同类型的数据，而 `var` 声明的变量后续赋值只能是与首次赋值的数据类型一直**。

`Object` 是以对象的方式声明变量，因为 `Object` 是所有子类的父类，所以和 `dynamic` 一样，**任何类型的值都可以赋值给 `Object` 声明的变量**，正因为 `Object` 是所有子类的父类这个特性，所以其他类型的对象也可以用来声明该类型的变量：

```dart
// 表示声明一个 List 类型的变量
List fruits = ['apple', 'banana', 'strawberry'];
// 表示声明一个 String 类型的变量
String name = '大板栗';
```

## 相关阅读

- [Const, Static, Final, Oh my!](https://news.dartlang.org/2012/06/const-static-final-oh-my.html)