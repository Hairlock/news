import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:news/src/models/item_model.dart';
import 'repository.dart';

final String _apiUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_apiUrl/topstories.json');

    return json.decode(response.body).cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_apiUrl/item/$id.json');

    return ItemModel.fromJson(json.decode(response.body));
  }
}
