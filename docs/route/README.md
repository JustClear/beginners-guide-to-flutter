# 路由

一般一个应用都是由多个页面组成的，而这些页面间的相互访问（跳转）是如何管理的呢，这就本章节要讲的 **路由**。

假设我们有两个页面 `Home` 和 `About`：

```dart
// Home
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
          },
          child: Text('open page About'),
        ),
      ),
    );
  }
}

// About
class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Back to Home'),
        ),
      ),
    );
  }
}
```

上面两个页面实现了从 Home 页面 **跳转** 到 About 页面和从 About 页面 **返回** 到 Home 页面的逻辑：

**跳转**：

```dart
final route = MaterialPageRoute(builder: (context) => SomePage());
Navigator.push(context, route);
```

**返回**：

```dart
Navigator.pop(context)
```

会发现 Dart 中的路由跳转和返回的方法和 Web 浏览器路由方法一样，跳转都是 `.push()` 返回都是 `.pop()`。

Dart 中「跳转」和「返回」第一个参数都是当前页面的 `context`，不同的是 **跳转需要第二个参数**，也就是 `PageRoute` 类，它定义了路由切换是的过渡动画的相关接口及属性，而上面的 `MaterialPageRoute` 是 Flutter 官方实现的 **与与平台页面切换动画风格一致的路由切换动画**：

- 在 Android 中，打开新页面时，页面会从底到顶的方式进入页面。关闭页面时和打开相反，从顶到底最后消失，同时上一个页面会显示到屏幕中。
- 在 iOS 中，新页面会从又到左的方向进入屏幕，上一个页面也以从右到左的方式逐渐消失。关闭页面时也是与打开相反。

## Navigator 常用方法

### 普通路由

#### .push()

通过给定的 `context` 和路由进行跳转：

```dart
Navigator.push(context, MaterialPageRoute(builder: (context) => SomePage()));
```

#### .pop()

路由被 `.push()` 后，就像一个 **栈结构**， 是一种后进先出的结构，所以 `.pop()` 会将 **最顶部（最后 `.push()`）** 的路由 **出栈**：

```dart
// push
Navigator.push(context, MaterialPageRoute(builder: (context) => PageA()));
Navigator.push(context, MaterialPageRoute(builder: (context) => PageB()));
Navigator.push(context, MaterialPageRoute(builder: (context) => PageC()));
// pop
Navigator.pop(context); // 推出 PageC 回到 PageB
Navigator.pop(context); // 推出 PageB 回到 PageA
```
<!-- 
#### .replace()

Replaces a route on the navigator that most tightly encloses the given context with a new route.

```dart
// routes
final routeA = MaterialPageRoute(builder: (context) => PageA());
final routeB = MaterialPageRoute(builder: (context) => PageB());
final routeC = MaterialPageRoute(builder: (context) => PageC());
// push
Navigator.push(context, routeA);
Navigator.push(context, routeB);
// 因为在路由栈中，PageC 会替换 PageB 的位置
Navigator.replace(context, routeB, routeC);
// pop
// 所以推出 PageC 会回到 PageA
Navigator.pop(context); 
``` -->

### 命名路由

所谓命名路由就是给路由起一个名字，然后可以直接通过路由名字来跳转页面。

#### 路由映射

想要通过 **路由名** 来进行跳转，就必须存在 `路由名 => 路由` 的一种映射表，这样 Flutter 才知道哪个名称对应哪个路由页面，路由映射表的定义如下：

```dart
// Map<String, (BuildContext) → Widget> routes: const <String, WidgetBuilder> {}
Map<String, WidgetBuilder> routes = {
    'home': (context) => Home(),
    'about': (context) => About(),
};
```

#### 注册路由映射表

映射表定以后需要一个地方注入：

```dart
void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: Home(), // 首页
      routes: routes,
    );
  }
}
```

#### .pushNamed()

定义并注册好路由后，就可以使用命名路由了：

```dart
// Future pushNamed(BuildContext context, String routeName)
Navigator.pushNamed(context, 'home');
Navigator.pushNamed(context, 'about');
```

#### .popAndPushNamed()

推出当前路由并以命名路由的方式推入一个新路由：

```dart
Navigator.pushNamed(context, 'home');
Navigator.pushNamed(context, 'about');
// 在路由栈中 introduction 会替换 about 的位置
Navigator.popAndPushNamed(context, 'introduction');
// 所以 .pop() 后会回到 home 页
Navigator.pop(context);
```

### 其他方法

`Navigator` 还有许多其他路由方法，有兴趣可以查看 API 文档：

- `.replace()`
- `.popUntil()`
- `.removeRoute()`
- `.pushReplacement()`
- `.pushReplacementNamed()`
- `.pushAndRemoveUntil()`
- `.pushNamedAndRemoveUntil()`
- `...`

命名路由的优点就是 **简单明了** 使用方便，但是，如果需要给路由传递 **动态数据** 时，命名路由就无能为力了：

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: Home(), // 首页
      routes: {
          // 因为是在入口页注册路由，所以不能传一些路由跳转的那一页的数据
          'about': (context) => About('只能传固定的数据'),
      },
    );
  }
}

// 非命名路由
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 可以传当前页的一些动态数据
    final Map about = {
      // some dynamic data here...
    };
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => About(about)));
          },
          child: Text('open page About'),
        ),
      ),
    );
  }
}
```

## 小结

如没有 **传递动态参数** 需求的路由建议用 **命名路由**，反之则使用普通非命名路由。