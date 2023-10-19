import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/resource/data.dart';
import 'package:newsapp/resource/news.dart';
import 'package:newsapp/resource/sourcd.dart';

class ModelProvider with ChangeNotifier {
  int _x = 23;
  int get index => _x;
  bool loading = true;
  final news = News();
  List<CategoryModel> _categories = [];
  List<ArticleModel> _articles = [];
  List<CategoryModel> get categories => _categories;
  List<ArticleModel> get articles => _articles;

  ModelProvider() {
    getNews();
  }

  Future<void> getNews() async {
    _categories = getCategories();
    final news = News();
    await news.getNews(countrycode: countrycode[_x]);
    _articles = news.news;
    loading = false;
    notifyListeners();
  }

  getcategorydata({required String category}) async {
    await news.getNews(countrycode: countrycode[_x], category: category);
    _articles = news.news;
    notifyListeners();
  }

  getsearchdata({required String search}) async {
    await news.getNews(countrycode: countrycode[_x], search: search);
    _articles = news.news;
    notifyListeners();
  }

  getdatta(int indexs) async {
    if (_x == indexs) {
      return;
    }

    _x = indexs;
    await news.getNews(countrycode: countrycode[_x]);
    _articles = news.news;
    notifyListeners();
  }
}
