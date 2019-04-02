# 列表（List）

Dart 中的 `List` 相当于 JavaScript 中的 `Array`，它们都表示一个 **有序数列的集合**。

## 列表的声明

Dart 中的 List 分为 **可变长度列表** 和 **固定长度列表**，它们以声明的方式来区分：

**可变长度列表**

```dart
// 以默认方式（`new List()` 或 `[]`）来声明则表示「可变长度」列表
List nums = new List();
// or
List nums = [];
// 定义 List 长度
nums.length = 6; // [null, null, null, null, null, null]
// 添加项目
nums.add(10086); // [null, null, null, null, null, null, 10086]
// 修改第一项
nums[0] = 9527; // [9527, null, null, null, null, null, 10086]
```

**可变长度列表**

```dart
// 表示 List 的长度为 6
List nums = new List(6);
// 一旦以构造函数的方式定义好 List 长度后
// 后续无法以任何方式修改 List 的长度
nums.length = 0; // Unsupported operation: set length
// 无法增加项目
nums.add(10086); // Unsupported operation: add
// 可以通过 index 修改范围内的值
nums[0] = 10086; // work!
```

JavaScript 中的 `Array` 则没有这些限制：

```js
const nums = new Array(6); // [empty × 6]
nums.length = 3; // [empty × 3]
nums[0] = 1; // [1, empty × 2]
```

<!-- ## 静态方法对比

|compare|Dart List|JavaScript Array|
|:----:|:----:|:----:|
| of | List.of()|Array.of()|
| from |List.from()|Array.from()|

**`.of()`**

Dart `List.of()`:

JavaScript `Array.of()`:

**`.from()`**

Dart `List.from()`:

```dart

```

JavaScript `Array.from()`:

```dart

``` -->

## 属性

`.first` 返回列表中第一个元素

`.last` 返回列表中最后一个元素

`.length` 返回列表的长度

`.isEmpty` 返回列表是否为空

## 常用方法

`.add(element)` 给列表中添加一个 `element`, 与 JavaScript 中的 `.push()` 类似

```dart
List fruits = ['apple', 'banana'];
fruits.add('pineapple');
print(fruits); // ['apple', 'banana', 'pineapple']

// JavaScript
const fruits = ['apple', 'banana'];
fruits.push('pineapple');
console.log(fruits); // ['apple', 'banana', 'pineapple']
```

`.join(String separator = '')` 用 `separator` 拼接列表的元素并返回字符串

```dart
List fruits = ['apple', 'banana', 'pear'];
// separator 默认为 ''
var joined = fruits.join('+'); // apple+banana+pear

// JavaScript
const fruits = ['apple', 'banana', 'pear'];
const joined = fruits.join('+'); // apple+banana+pear
```

`.indexOf(element)` 返回第一个（从左向右）匹配 `element` 的 `index`，与 JavaScript 一致

```dart
List fruits = ['apple', 'banana', 'pear'];
fruits.indexOf('banana'); // 1

// JavaScript
const fruits = ['apple', 'banana', 'pear'];
fruits.indexOf('banana'); // 1
```

`.lastIndexOf(element)` 返回第一个（从右向左）匹配 `element` 的 `index`，与 JavaScript 一致

```dart
List fruits = ['apple', 'banana', 'pear'];
fruits.lastIndexOf('apple'); // 2

// JavaScript
const fruits = ['apple', 'banana', 'pear'];
fruits.lastIndexOf('apple'); // 2
```

`.contains(element)` 判断列表中是否存在 `element` 元素，返回 `true` or `false`，与 JavaScript 中的 `.includes()` 类似

```dart
List fruits = ['apple', 'banana', 'pear'];
fruits.contains('apple'); // true
fruits.contains('pineapple'); // false

// JavaScript
const fruits = ['apple', 'banana', 'pear'];
fruits.includes('apple'); // true
fruits.includes('pineapple'); // false
```

`.sort()` 给列表排序，与 JavaScript 一致

```dart
List nums = [1, 2, 3, 4, 5, 6];
nums.sort((a, b) => b - a);
print(nums); // [6, 5, 4, 3, 2, 1]

// JavaScript
const nums = [1, 2, 3, 4, 5, 6];
const sorted = nums.sort((a, b) => b - a);
console.log(sorted); // [6, 5, 4, 3, 2, 1]
```

!> 与 JavaScript 不同，Dart 中的 `.sort()` 没有返回值，会改变列表自身的排序，

`.forEach()` 遍历列表中的每一个元素，与 JavaScript 一致

```dart
List fruits = ['apple', 'banana', 'pear'];
fruits.forEach((fruit) => print(fruit)); // => apple banana pear
```

`.map()` 基本与 JavaScript 中的一致，不同的是 Dart 中 `map` 返回的是 `Iterable`，得调用 `.toList()` 才能获取到 `map` 后的列表：

```dart
List nums = [1, 2, 3];
List added = nums.map((a) => a + 1).toList(); // [2, 3, 4]
```

`.where()` 基本与 JavaScript 中的 `.filter()` 一致，不同的是 Dart 中 `where` 返回的是 `Iterable`，得调用 `.toList()` 才能获取到 `where` 后的列表：

```dart
List nums = [1, 2, 3];
List result = nums.where((a) => a == 1).toList(); // [1]
List result2 = nums.where((a) => a > 1).toList(); // [2, 3]
```

`.reduce()` 和 `.flod()`

```dart
var nums = [1, 2, 3, 4];
const initialValue = 0;
var sum = nums.fold(0, (prev, current) => prev + current); // 10
var sum = nums.reduce((prev, current) => prev + current); // 10

// JavaScript 中的 reduce
const initialValue = 0;
const sum = nums.reduce((prev, current) => prev + current, initialValue); // 10
```

?> Dart 中的 `.reduce()` 和 JavaScript 中的有些不一样，反而 `.fold()` 更像，不同的是一个初始参数在前一个在后

`.every()` 判断列表中是否每个元素都符合某个条件，如果是则返回 `true` 反之返回 `false`

```dart
List<Map<String, dynamic>> heros = [
    {'name': '诸葛亮', 'age': 18},
    {'name': '刘备', 'age': 41},
    {'name': '刘禅', 'age': 22},
];

var isAdult = heros.every((hero) => hero['age'] >= 18); // true
var isNamedLiu = heros.every((hero) => hero['name'].startsWith('刘')); // true
```

`List.from(Iterable elements)` 创建一个包含所有可迭代 `elements` 的列表

```dart
// 复制列表
List fruits = ['apple', 'pear', 'watermelon'];
var cloned = List.from(fruits); // ['apple', 'pear', 'watermelon']

// JavaScript 中的 Array.from
const fruits = ['apple', 'pear', 'watermelon'];
const cloned = Array.from(fruits); // ["apple", "pear", "watermelon"]
```

?> JavaScript 中的 `Array.from()` 效果和 Dart 中的 `List.from()` 还是一致的。

`.toList()` 为当前迭代器创建一个包含该迭代器元素的列表（内部是用 `List.from()` 实现的）

```dart
List<E> toList({bool growable: true}) {
  return new List<E>.from(this, growable: growable);
}
```

## 小结

Dart 中对于 `List` 的操作其实大多都和 JavaScript 中的 `Array` 是类似的，只要记住它们的不同之处再配合对 JavaScript 已有的了解，对于 Dart 中的 `List` 的操作应该是没什么大问题。