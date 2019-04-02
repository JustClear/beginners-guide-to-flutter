# 一个简单的页面

<!-- <p align="center"><img width="50%" src="https://raw.githubusercontent.com/JustClear/flutter-tutorials-for-front-end/master/docs/images/1.jpg"></p> -->

```dart
// /lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('大板栗');
  }
}
```

这是一个最简单的页面，会在屏幕上显示一个文本 `大板栗`，我们可以从这个简单的页面中了解到几个点：

1. Flutter 应用和 Java 应用一样，都是 **以一个 `main()` 函数为入口函数**
2. Flutter 以 `runApp()` 方法来启动一个 `Home`（`Widget`）
3. `Home` 组件有一个 `build()` 方法来执行页面渲染
4. 用 `Text` 组件来渲染文本

其中 `Home` 是一个封装了 `Text` 组件的 **自定义组件**。