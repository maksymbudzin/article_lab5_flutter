import 'dart:convert';
import 'api_model.dart';
import 'package:http/http.dart' as http;

class AppStrings {
  static String url =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=ce35362a86124c8f9bc20de4cac6bb18#";
}

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(Uri.parse(AppStrings.url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = ApiResultModel.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }
  }
}
