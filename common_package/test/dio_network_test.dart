import 'dart:typed_data';

import 'package:common_package/helpers/dio_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

Future<RequestOptions> _captureRequest(
  Future<Response<dynamic>> Function(DioNetwork network) send,
) async {
  late RequestOptions captured;
  final network = DioNetwork(baseUrl: 'https://example.test');

  DioNetwork.dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        captured = options;
        handler.resolve(
          Response<dynamic>(
            requestOptions: options,
            statusCode: 200,
            data: <String, dynamic>{},
          ),
        );
      },
    ),
  );

  await send(network);
  return captured;
}

void main() {
  test('encodes scalar lists as repeated [] multipart fields', () async {
    final options = await _captureRequest(
      (network) => network.postData(
        endPoint: '/employees',
        data: <String, dynamic>{
          'permissionIds': [1, 2],
          'profileImage': Uint8List.fromList([1, 2, 3]),
        },
      ),
    );

    final formData = options.data as FormData;
    expect(
      formData.fields
          .where((field) => field.key == 'permissionIds[]')
          .map((field) => field.value)
          .toList(),
      ['1', '2'],
    );
    expect(
      formData.fields.any((field) => field.key == 'permissionIds'),
      isFalse,
    );
  });

  test('does not add a second [] suffix to existing list keys', () async {
    final options = await _captureRequest(
      (network) => network.postData(
        endPoint: '/employees',
        data: <String, dynamic>{
          'images[]': ['front', 'back'],
          'profileImage': Uint8List.fromList([1]),
        },
      ),
    );

    final formData = options.data as FormData;
    expect(
      formData.fields
          .where((field) => field.key == 'images[]')
          .map((field) => field.value)
          .toList(),
      ['front', 'back'],
    );
    expect(formData.fields.any((field) => field.key == 'images[][]'), isFalse);
  });

  test('keeps scalar lists as JSON arrays when there are no files', () async {
    final options = await _captureRequest(
      (network) => network.postData(
        endPoint: '/employees',
        data: <String, dynamic>{
          'permissionIds': [1, 2],
        },
      ),
    );

    expect(options.data, isA<Map<String, dynamic>>());
    expect((options.data as Map<String, dynamic>)['permissionIds'], [1, 2]);
  });
}
