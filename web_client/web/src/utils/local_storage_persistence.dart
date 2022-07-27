import 'dart:async';
import 'dart:html' as html;

import 'package:room_signals_client/room_signals_client.dart';

class ClientPersistenceLocalStorage with ClientPersistence {
  const ClientPersistenceLocalStorage();

  @override
  FutureOr<bool> delete(String key) {
    return html.window.localStorage.remove(key) != null;
  }

  @override
  FutureOr<String?> get(String key) {
    return html.window.localStorage[key];
  }

  @override
  FutureOr<void> put(String key, String value) {
    html.window.localStorage[key] = value;
  }
}
