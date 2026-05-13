import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// Debug-mode NDJSON logging (session f1d791). Do not log secrets/PII.
void debugAgentLog({
  required String hypothesisId,
  required String location,
  required String message,
  Map<String, Object?> data = const {},
  String runId = 'pre-fix',
}) {
  final payload = <String, Object?>{
    'sessionId': 'f1d791',
    'hypothesisId': hypothesisId,
    'location': location,
    'message': message,
    'data': data,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
    'runId': runId,
  };
  final line = jsonEncode(payload);
  debugPrint('AGENT_LOG $line');
  if (kIsWeb) return;
  unawaited(_debugAgentLogSink(line));
}

Future<void> _debugAgentLogSink(String line) async {
  const candidates = [
    r'd:\flutter_pro\dllni_resturant_owner_app\debug-f1d791.log',
    'debug-f1d791.log',
  ];
  for (final p in candidates) {
    try {
      await File(p).writeAsString('$line\n', mode: FileMode.append, flush: true);
      break;
    } catch (_) {}
  }
  try {
    final host = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
    final client = HttpClient();
    final req = await client.postUrl(Uri.parse('http://$host:7273/ingest/5845944d-a837-45ac-a432-04a91a32941f'));
    req.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    req.headers.set('X-Debug-Session-Id', 'f1d791');
    req.write(line);
    await req.close();
    client.close(force: true);
  } catch (_) {}
}
