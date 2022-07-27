import 'package:rad/rad.dart';
import 'package:rad/widgets_short_html.dart';

import 'provider.dart';

class Theme {
  final CardTheme cardTheme;

  const Theme({
    required this.cardTheme,
  });
}

class CardTheme {
  final String? style;

  const CardTheme({
    this.style,
  });

  static CardTheme? of(BuildContext context) =>
      Provider.maybeOf<CardTheme>(context) ??
      Provider.maybeOf<Theme>(context)?.cardTheme;
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    this.style,
    required this.child,
  });

  final Widget child;
  final String? style;

  @override
  Widget build(BuildContext context) {
    final theme = CardTheme.of(context);
    return div(
      style: 'box-shadow:1px 2px 4px rgba(0, 0, 0, 0.4); '
          'padding:14px;border-radius:6px;margin:6px;${style ?? theme?.style ?? ''}',
      child: child,
    );
  }
}
