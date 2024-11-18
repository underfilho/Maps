import 'package:flutter/material.dart';

extension MyRouterHelper on BuildContext {
  Future<T?> push<T extends Object?>(String path, {Object? args}) =>
      Navigator.of(this).pushNamed(path, arguments: args);

  Future<T?> replace<T extends Object?>(String path, {Object? args}) =>
      Navigator.of(this).pushReplacementNamed(path, arguments: args);

  void pop<T extends Object?>([Object? result]) =>
      Navigator.of(this).pop(result);

  void maybePop<T extends Object?>([Object? result]) =>
      Navigator.of(this).maybePop(result);

  void popAllAndPush<T extends Object?>(String path, {Object? result}) =>
      Navigator.of(this).pushNamedAndRemoveUntil(path, (route) => false);
}
