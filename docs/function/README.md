# 函数

和 JavaScript 一样，Dart 中的函数 **既是函数也是对象**。**既可以赋值给变量也可以作为参数传递给某个函数（函数式编程的特点）**，而且也拥有一个类型 `Function`。

## 函数声明

和 JavaScript 不同的是，Dart 中声明函数不需要 `function` 关键字：

```dart
greeting() {
    print('你好，大板栗！');
}
```

但是一般会在函数名前面添加一个 **表示返回值类型** 的关键字（推荐这么做）：

```dart
// 表示没有返回值
void greeting() {
    print('你好，大板栗！');
}

// 表示返回值的类型是 String
String greeting() {
    return '你好，大板栗！';
}

// 表示返回值的类型是 Function
Function greeting() {
    String hello() => '你好，大板栗！';
    return hello;
}
```

?> 和 JavaScript 一样，如果函数的返回值只有一个表达式，那么可以使用箭头函数 `=>` 简化声明方式。

如果函数在声明时没有显示的指定返回类型的话，其返回值会被当成 `dynamic` 类型来处理：

!> **函数的返回值没有类型推断**。

```dart
greeting() {
    return '你好，大板栗！';
}
// and
dynamic greeting() {
    return '你好，大板栗！';
}
```

上面两个函数意义是一致的。

## 函数的参数

和 JavaScript 不同的是，Dart 中的函数 **必须显示的去表示某些参数是可选的**，：

```dart
String say(name, [age]) {
    var result = '我叫${name}';
    if(age != null) {
        result = '${result}，今年 ${age} 岁。';
    }
    return result;
}
// 使用
say('大板栗', 18); // 我叫大板栗，今年 18 岁。
```

上面 `[]` 包裹起来的参数表示可选的参数。

虽然函数参数在声明时没有必须要求指定参数的类型，但是推荐在声明时指定参数的类型：

```dart
String say(String name, [int age]) {
    var result = '我叫 ${name}';
    if(age != null) {
        result = '${result} 今年 $age 岁';
    }
    return result;
}
```

?> 和 JavaScript 一样，Dart 中也可以使用 `${}` 来表示字符串插值，不同的是 JavaScript 中必须在 <code>\`</code> 符号表示的字符串中才能使用 `${}`，而 Dart 中在 `'` 或者 `"` 表示的字符串中即可使用 `${}` 来表示字符串插值，而且 Dart 中还可以用 `$variableName` 来简化表示，比如上面的 `$name`。

## 命名参数

函数声明时可以用 `{}` 包裹参数的方式来声明 **命名参数**：

```dart
String say({String name, [int age]}) {
    var result = '我叫 ${name}';
    if(age != null) {
        result = '${result} 今年 $age 岁';
    }
    return result;
}
// 使用
say(name: '大板栗'); // 我叫大板栗
say(name: '大板栗', age: 18); // 我叫大板栗，今年 18 岁。
```