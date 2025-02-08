import 'package:doctor_mobile_admin_panel/api/articles_api/articles_api.dart';
import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/models/article_paragraph.dart';
import 'package:doctor_mobile_admin_panel/models/article_response_model.dart';
import 'package:flutter/material.dart';

class PxArticles extends ChangeNotifier {
  final HxArticles service;

  PxArticles({required this.service}) {
    _fetchArticlesOfOneDoctor();
  }

  static List<ArticleResponseModel>? _articles;
  List<ArticleResponseModel>? get articles => _articles;

  Future<void> _fetchArticlesOfOneDoctor() async {
    _articles = await service.fetchArticlesOfOneDoctor();
    notifyListeners();
  }

  Future<void> addNewArticle(Article article) async {
    await service.AddNewArticle(article);
    await _fetchArticlesOfOneDoctor();
  }

  Future<void> updateArticleData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await service.updateArticleData(id, update);
    await _fetchArticlesOfOneDoctor();
  }

  Future<void> deleteArticle(String id) async {
    await service.deleteArticle(id);
    await _fetchArticlesOfOneDoctor();
  }

  Future<void> updateArticleTumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    await service.updateArticleThumbnail(
      id: id,
      fileBytes: fileBytes,
      fileName_key: fileName_key,
    );
    await _fetchArticlesOfOneDoctor();
  }

  Future<void> addParagraphToArticle(ArticleParagraph paragraph) async {
    await service.addParapraphToArticle(paragraph);
    await _fetchArticlesOfOneDoctor();
  }

  Future<void> updateParagraphData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await service.updateParagraphData(id, update);
    await _fetchArticlesOfOneDoctor();
  }

  Future<void> deleteParagraph(String id) async {
    await service.deleteParagraphFromArticle(id);
    await _fetchArticlesOfOneDoctor();
  }
}
