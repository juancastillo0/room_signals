// ignore_for_file: constant_identifier_names

import 'package:rad/rad.dart';
import 'package:rad/widgets_short_html.dart';

class Column extends StatelessWidget {
  const Column({
    super.key,
    required this.children,
    this.main = AxisAlign.start,
    this.cross = AxisAlign.center,
    this.wrap,
    this.expand = true,
  });

  final List<Widget> children;
  final AxisAlign main;
  final AxisAlign cross;
  final FlexWrap? wrap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return div(
      style: colStyle(cross: cross, expand: expand, main: main, wrap: wrap),
      children: children,
    );
  }
}

class Row extends StatelessWidget {
  const Row({
    super.key,
    required this.children,
    this.main = AxisAlign.start,
    this.cross = AxisAlign.center,
    this.wrap,
    this.expand = true,
  });

  final List<Widget> children;
  final AxisAlign main;
  final AxisAlign cross;
  final FlexWrap? wrap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return div(
      style: flexStyle(cross: cross, expand: expand, main: main, wrap: wrap),
      children: children,
    );
  }
}

enum AxisAlign {
  start,
  end,
  center,
  stretch,
  space_around,
  space_between,
  space_evenly,
  baseline,
}

extension MainAxisAlignExt on AxisAlign {
  String get nameHtml => toString().split('.').last.replaceAll('_', '-');
}

String flexCenter({bool column = false}) {
  return flexStyle(
    main: AxisAlign.center,
    cross: AxisAlign.center,
    column: column,
  );
}

enum FlexWrap {
  wrap,
  wrap_reverse,
  nowrap,
}

extension FlexWrapExt on FlexWrap {
  String get nameHtml => toString().split('.').last.replaceAll('_', '-');
}

String flexStyle({
  bool column = false,
  AxisAlign main = AxisAlign.start,
  AxisAlign cross = AxisAlign.center,
  FlexWrap? wrap,
  bool expand = true,
}) {
  return 'display:flex;${column ? 'flex-direction:column;' : ''}'
      'justify-content:${main.nameHtml};align-items:${cross.nameHtml};'
      '${wrap == null ? '' : 'flex-wrap:${wrap.nameHtml};'}'
      '${expand ? column ? 'height:100%;' : 'width:100%;' : ''}'; // ${column ? 'width:100%;' : 'height:100%;'}
}

String colStyle({
  AxisAlign main = AxisAlign.start,
  AxisAlign cross = AxisAlign.center,
  bool expand = true,
  FlexWrap? wrap,
}) {
  return flexStyle(
    column: true,
    main: main,
    cross: cross,
    expand: expand,
    wrap: wrap,
  );
}

class Flexible extends StatelessWidget {
  const Flexible({
    super.key,
    required this.child,
    this.flex = 1,
  });

  final Widget child;
  final int flex;

  @override
  Widget build(BuildContext context) {
    // Widget? parent;
    // if (context is StatelessRenderElement) {
    //   parent = context.widget;
    // }
    return div(
      style: 'flex:$flex;${[
        // if (parent is Column) 'width:100%;',
        // if (parent is Row) 'height:100%;'
      ].join()};',
      child: child,
    );
  }
}
