import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// Sends one NDJSON line to the debug ingest server (session f69664). No secrets/PII in [data].
void agentDebugLog({
  required String hypothesisId,
  required String location,
  required String message,
  Map<String, Object?> data = const {},
  String runId = 'pre-fix',
}) {
  final payload = <String, Object?>{
    'sessionId': 'f69664',
    'location': location,
    'message': message,
    'data': data,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
    'hypothesisId': hypothesisId,
    'runId': runId,
  };
  if (kDebugMode) {
    debugPrint('[agentDebug] ${jsonEncode(payload)}');
  }
  Future.microtask(() async {
    try {
      final host = (!kIsWeb && Platform.isAndroid) ? '10.0.2.2' : '127.0.0.1';
      final client = HttpClient();
      final uri = Uri.parse('http://$host:7242/ingest/1550a868-82bd-41bb-99f8-373b4b7daddd');
      final req = await client.postUrl(uri);
      req.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      req.headers.set('X-Debug-Session-Id', 'f69664');
      req.write(jsonEncode(payload));
      await req.close();
      client.close(force: true);
    } catch (_) {}
    try {
      final f = File(r'g:\my_projects\dllni_com\dllni_resturant_owner_app\debug-f69664.log');
      f.writeAsStringSync('${f.existsSync() ? f.readAsStringSync() : ''}${jsonEncode(payload)}\n', mode: FileMode.append);
    } catch (_) {}
  });
}
