# 生命周期

本章节会对比 React 的生命周期来学习 Flutter。

## 一个简单的 StatelessWidget

```dart
class App extends StatelessWidget {
    final name;
    App(this.name);

    @override
    Widget build(BuildContext context) {
        return Text(name);
    }
}
```

一个 **无状态组件** 至少必须包含一个 `build` 方法，类似 React 中的 `render` 函数：

```js
// class component
class App extends React.Component {
    render() {
        return this.props.name;
    }
}
// function component
function App({name}) {
    return name;
}
```

Flutter 中的 `StatelessWidget` 与 React 中的 **函数式组件** 非常相似，它们自身不管理状态，而是父组件通过 **传参的方式** 从外部获取状态， 它们都是 **纯 UI 组件**，传入参数不变，UI 永远不变。

## 一个简单的 StatefulWidget

既然有无状态组件，肯定也会有 **有状态组件**，Flutter 中 `StatefulWidget` 表示 有状态组件，不同于 无状态组件 的是，有状态组件 除了要实现 `build` 方法外，还必须实现一个 `createState` 方法，且 `build` 方法必须放在另一个 `State` 类中实现。：

```dart
class App extends StatefulWidget {
    @override
    AppState createState() => AppState();
}

class AppState extends State<App> {
    final name;

    @override
    void initState() {
        super.initState();
        setState(() {
            name = '大板栗';
        });
    }

    @override
    Widget build(BuildContext context) {
        return Text(name);
    }
}
```

一个 **有状态** 的组件自身可以管理状态，类似 React 中的 `class` 类型组件：

```js
class App extends React.Component {
    state = {
        name: '',
    }
    componentDidMount() {
        this.setState({
            name: '大板栗';
        });
    }
    render() {
        return this.state.name;
    }
}
```

类似于 React 中的 `this.setState()`，Flutter 中的 `setState()` 也是用来设置状态的，不同的是 Flutter 中的 `setState()` 方法只接收一个函数作为参数，必须在该函数中对状态进行改变。

<!-- `StatefulWidget` 类为什么需要一个 `State` 类辅助才能使用：一切为了 **性能**。

因为 `State` 对象是长期存在的，而 `StatefulWidget`（包括 `Widget` 所有的子类）都将在 **数据改变时** 被销毁并被重新构建（rebuild）。 -->

## StatefulWidget 的生命周期

### 1. createState()

当一个 `StatefulWidget` 组件被使用（插入组件树）时，`createState()` 将会立即被调用，且该函数必须存在。

```dart
class Home extends StatefulWidget {
    @override
    HomeState createState() => new HomeState();
}
```

### 2. mounted == true

当 `createState()` 创建了状态后，将被赋值给 `buildContext`。

所有的组件都有一个 `mounted` 属性，默认是 `false`，当 `buildContext` 被赋值时，`mounted` 的值将变成 `true`。

所以我们可以使用 `if (mounted) { setState() }` 来保证状态设置成功（类似 React 中的 `componentDidMount()`）。

### 3. initState()

`initState()` 是组件在创建后（除了构造函数外的）第一个被调用的函数。

**该函数只会被调用一次，且必须在该函数内调用 `super.initState()`**。

```dart
@override
void initState() {
  super.initState();
  // do some mutatable action here...
}
```

在该函数中适合做一些 **有副作用** 的操作：

1. 处理从 `context` 和 `widget` 中获取的值。
2. 订阅操作（可在 `didUpdateWidget()` 和 `dispose()` 中取消订阅）

### 4. didChangeDependencies()

该函数的第一次调用会在 `initState()` 方法执行后立即被调用。之后只要 `State` 发生改变，都会被调用。

子组件一般比较少 **重写**（`@override`）这个方法，因为 Flutter 总是会在该函数执行后立马调用一次 `build()` 方法。如果重写的话一般是用来处理一些 **昂贵的操作** 比如网络数据获取：

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  // do some fetching here...
}
```

### 5. build()

类似 React 的 `render()` 方法，Flutter 的 `build()` **也会被调用多次**，该函数 **必须返回一个 `Widget` 并且实现一个 `BuildContext` 参数 `context`**：

```dart
@override
Widget build(BuildContext context) {
    return Text('大板栗');
}
```

### 6. didUpdateWidget()

每当父组件变化时，该函数都会被执行。Flutter 总会会在该函数执行后调用一次 `build()` 方法。

该函数中通常用来做一些比如 **取消订阅**、**取消动画** 等等一些 **清除** 操作

### 7. deactivate()

该函数 **比较少使用**，当 `State` 从组件树中 **暂时性移除** 时该函数被调用。因为在 Flutter 中 `State` 是可以从组件树中的一个地方移动到另一个地方的。

### 8. dispose()

该函数中通常用来做一些比如 **取消订阅**、**取消动画** 等等一些 **清除** 操作，会在 `State` 被 **永久性移除** 时被调用。

### 9. mounted == false

当 `dipose()` 函数被调用时 `mounted` 属性值被置为 `false`。

## 小结

`mounted` 属性是判断组件是否在组件树中的标识，只有当 `mounted` 为 `true` 时，才能调用 `setState()` 函数，因为 `mounted` 是在 `createState()` 被调用后且 `initState()` 被调用前被赋值为 `true` 的。

Flutter 的生命周期函数 **是在 `State` 组件** 中的，而不是 `StatefulWidget` 组件中。