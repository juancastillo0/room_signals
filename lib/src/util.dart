import 'dart:math' show Random;

final _alphabet = 'abcdefghijklmnopqrstuvwxyz';
final _alphabetComplete =
    '0123456789$_alphabet${_alphabet.toUpperCase()}'.split('');

final _random = Random();

String randomId({int length = 32}) {
  return Iterable.generate(
    length,
    (_) => _alphabetComplete[_random.nextInt(_alphabetComplete.length)],
  ).join();
}

abstract class AppError implements Error {
  AppError({required StackTrace? stackTrace})
      : stackTrace = stackTrace ?? StackTrace.current;

  String get message;
  Enum get code;

  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return '${code.name}: $message';
  }
}
