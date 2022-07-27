import 'dart:html' as html;

import 'package:rad/rad.dart';
import 'package:rad/widgets_async.dart';

void Function(EmittedEvent) onInput(ValueNotifier<String> notifier) {
  return (e) {
    notifier.value = (e.target! as html.InputElement).value ?? '';
  };
}
