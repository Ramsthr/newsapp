import 'dart:convert';

import 'package:newsapp/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  String apiKey = "85940a4d7b23488ba7ecd9e9e7c6533e";
  // String countrycode = "in";
  String url = "https://newsapi.org/v2/top-headlines";

  Future<void> getNews(
      {required countrycode, String category = "", String search = ""}) async {
    String link;
    if (category.isEmpty && search.isEmpty) {
      link = "$url?country=$countrycode&apiKey=$apiKey";
    } else if (category.isNotEmpty && search.isEmpty) {
      link = "$url?country=$countrycode&category=$category&apiKey=$apiKey";
    } else if (category.isEmpty && search.isNotEmpty) {
      link = "$url?country=$countrycode&q=$search&apiKey=$apiKey";
    } else {
      link =
          "$url?country=$countrycode&q=$search&category=$category&apiKey=$apiKey";
    }

    news = [];
    print(link);
    http.Response response = await http.get(Uri.parse(link));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach(
        (element) {
          if (element["urlToImage"] != null &&
              element["description"] != null &&
              element['content'] != null &&
              element['author'] != null) {
            ArticleModel articleModel = ArticleModel(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
              publishedAt: element['publishedAt'],
            );
            news.add(articleModel);
          }
        },
      );
    }
  }
}
