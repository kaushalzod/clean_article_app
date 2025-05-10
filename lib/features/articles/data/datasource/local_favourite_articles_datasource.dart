import 'dart:convert';

import 'package:article_app/core/database/local_database.dart';
import 'package:article_app/features/articles/data/model/article_model.dart';

class LocalFavouriteArticlesDatasource {
  final LocalDatabase database;

  LocalFavouriteArticlesDatasource(this.database);
  final String _key = "favourites";

  ///  Get all articles from Local DB
  Future<List<ArticleModel>> getFavouriteArticles() async {
    var result = await database.getStringList(_key);
    final jsonList = result.map((strJson) => jsonDecode(strJson)).toList();
    return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
  }

  ///  Check if article exist in Local DB
  Future<bool> isFavouriteArticle(int id) async {
    var result = await database.getStringList(_key);
    final jsonList = result.map((strJson) => jsonDecode(strJson)).toList();
    final articles =
        jsonList.map((json) => ArticleModel.fromJson(json)).toList();
    return articles.any((item) => item.id == id);
  }

  ///  Set favourite article to Local DB
  Future<List<ArticleModel>> addFavouriteArticles(ArticleModel article) async {
    var result = await database.getStringList(_key);
    result = [article.toJson().toString(), ...result];
    await database.saveStringList(_key, result);
    final jsonList = result.map((strJson) => jsonDecode(strJson)).toList();
    return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
  }

  ///  Remove Favourite article from DB
  Future<List<ArticleModel>> removeFavouriteArticles(
    ArticleModel article,
  ) async {
    var result = await database.getStringList(_key);
    result.remove(article.toJson().toString());
    await database.saveStringList(_key, result);
    final jsonList = result.map((strJson) => jsonDecode(strJson)).toList();
    return jsonList.map((json) => ArticleModel.fromJson(json)).toList();
  }
}
