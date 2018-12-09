import 'package:test/test.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/resources/news_api_provider.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((req) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((req) async {
      return Response(json.encode({'id': 123}), 200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
