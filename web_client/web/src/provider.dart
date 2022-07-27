import 'package:rad/rad.dart';

class Provider<T> extends InheritedWidget {
  final T value;

  const Provider({
    required this.value,
    required super.child,
  });

  @override
  bool updateShouldNotify(Provider<T> oldWidget) {
    return value != oldWidget.value;
  }

  static T of<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider<T>>()!.value;
  static T? maybeOf<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Provider<T>>()?.value;
  static T get<T>(BuildContext context) =>
      context.findAncestorWidgetOfExactType<Provider<T>>()!.value;
  static T? maybeGet<T>(BuildContext context) =>
      context.findAncestorWidgetOfExactType<Provider<T>>()?.value;
}
