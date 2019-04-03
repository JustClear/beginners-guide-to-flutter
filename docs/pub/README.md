# 包管理（Pub）

一个完整的程序往往会依赖于许多第三方包，类似于 JavaScript 中的 **npm** 或 **yarn**，iOS 中的 **Cocoapods** 或 **Carthage**，Android 中的 **Gradle**，都是用来管理第三方库的工具，而本章节要讲的 **Pub** 就是 Dart 中的包管理器。

类似于 npm 或 yarn 的配置文件是 `package.json`（位于项目根目录），pub 的配置文件名是 `pubspec.yml`，`.yml` 和 `.json` 一样，也是一种简单易解析一种文件格式，下面是一个简单的 `pubspec.yml` 示例：

```yml
# pubspec.yml
name: HelloWorld
description: Awesome Flutter App.

version: 1.0.0+1

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```

其实和 `package.json` 大同小异，下面将一一介绍每个字段的含义：

- name: 应用或包名称
- description: 应用或包的描述
- version: 应用或包的版本
- dependencies: 应用或包的依赖
- dev_dependencies: 开发环境下应用或包的依赖
- flutter: flutter 相关配置

## Pub 仓库

类似于 JavaScript 的包仓库 NPM [npmjs.com](https://npmjs.com)，Pub [https://pub.dartlang.org/](https://pub.dartlang.org/) 是 Dart 的包仓库。

### 安装一个包

需要安装一个第三方包的话，需要先在 `pubspec.yml` 中定义相关依赖，然后在项目根目录运行 `flutter package get` 命令（如果使用 VSCode 的话，会自动安装），比如安装一个 `dio` 包：

```yml
# ...
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2
  dio: ^2.0.20 # 新增包依赖
# ...
```

如果需要卸载的话，就删除相关依赖然后再次运行 `flutter package get`。

### 其他依赖方式

除了上面第三方包的依赖方式以外，`pubspec.yml` 还支持直接依赖 `Git` 和本地包：

**依赖 Git**：

```yml
dependencies:
    some-package:
        git:
            url: https://github.com/JustClear/some-package.git
```

**依赖本地包**：

```yml
dependencies:
    some-package:
        path: path/to/some-package
```

可以是 **相对地址** 也可以是 **绝对地址**。

### 引用一个包

```dart
// 引用第三方包
// 引用本地文件
import 'path/to/package'; // 可以使用该包的所有子模块
import 'path/to/package' show get; // 导出一个子模块
import 'path/to/package' show get, post, delete; // 导出多个子模块
import 'path/to/package' as common; // 所有子模块被放到 common 对象上
import 'path/to/package' hide delete, ...; // 除了 delete 子模块，其他都默认导出
delete(); // 无法使用 delete 子模块模块
```

其实和 ES6 的模块导入非常相似：

```js
import 'path/to/package'; // 可以使用该包的所有子模块
import { get } from 'path/to/package'; // 导出一个子模块
import { get, post, delete } from 'path/to/package'; // 导出多个子模块
import * as common from 'path/to/package'; // 所有子模块被放到 common 对象上
```

通过对比应该很容易理解 Dart 中是如何引入包的，还有一点值得一提的是，Dart 中的包无需使用类似 JavaScript 中的 `export` 关键字来导出某个子模块，**所有顶层非 `_` 开头的变量或函数都会默认导出**：

?> 以 `_` 开头的都属于 **私有成员**，外部无法访问。

```dart
void get() {} // 默认可导出
void post() {} // 默认可导出
void _delete() {} // 私有成员，无法导出
```

JavaScript 中必须用 `export` 标识：

```js
export const get = () => {};
export const post = () => {};
const delete = () => {}; // 外部无法通过 `import { delete } from './package'` 方式访问
```

## 小结

虽然在 Dart 中直接 `import` 某个包可以直接访问其子模块方法，但是还是 **推荐使用 `as`、`show` 的方式显示的导入某个需要使用的子模块**：

```dart
// 不推荐
import 'package:dio/dio.dart';
// 推荐
import 'package:dio/dio.dart' show Dio;
```