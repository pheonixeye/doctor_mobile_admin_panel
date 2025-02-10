import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/models/article_paragraph.dart';
import 'package:doctor_mobile_admin_panel/models/article_response_model.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class HxArticles {
  const HxArticles({required this.doc_id});

  final String doc_id;

  static const String collectionArticles = 'articles';

  static const String collectionParagraphs = 'articles_paragraphs';

  static const String _expand = 'paragraphs_ids';

  Future<List<ArticleResponseModel>> fetchArticlesOfOneDoctor() async {
    final _result =
        await PocketbaseHelper.pb.collection(collectionArticles).getFullList(
              filter: 'doc_id = "$doc_id"',
              expand: _expand,
            );

    return _result.map((e) {
      return ArticleResponseModel(
        article: Article.fromJson(e.toJson()),
        paragraphs: e
            .get<List<RecordModel>>('expand.$_expand')
            .map((p) => ArticleParagraph.fromJson(p.toJson()))
            .toList(),
      );
    }).toList();
  }

  Future<ArticleResponseModel> AddNewArticle(Article article) async {
    final _result =
        await PocketbaseHelper.pb.collection(collectionArticles).create(
              body: article.toJson(),
              expand: _expand,
            );

    final _docRef = await PocketbaseHelper.pb
        .collection(HxProfile.collection)
        .getOne(doc_id);

    final _doctor = Doctor.fromJson(_docRef.toJson());

    final _update = {
      'article_ids': [
        ..._doctor.article_ids,
        _result.id,
      ],
    };

    await PocketbaseHelper.pb.collection(HxProfile.collection).update(
          article.doc_id,
          body: _update,
        );

    return ArticleResponseModel(
      article: Article.fromJson(_result.toJson()),
      paragraphs: _result
          .get<List<RecordModel>>('expand.$_expand')
          .map((p) => ArticleParagraph.fromJson(p.toJson()))
          .toList(),
    );
  }

  Future<ArticleResponseModel> updateArticleData(
      String id, Map<String, dynamic> update) async {
    final _result =
        await PocketbaseHelper.pb.collection(collectionArticles).update(
              id,
              body: update,
              expand: _expand,
            );

    return ArticleResponseModel(
      article: Article.fromJson(_result.toJson()),
      paragraphs: _result
          .get<List<RecordModel>>('expand.$_expand')
          .map((p) => ArticleParagraph.fromJson(p.toJson()))
          .toList(),
    );
  }

  Future<ArticleResponseModel> updateArticleThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final _result =
          await PocketbaseHelper.pb.collection(collectionArticles).update(id,
              files: [
                http.MultipartFile.fromBytes(
                  fileName_key,
                  fileBytes,
                  filename: fileName_key,
                ),
              ],
              expand: _expand);

      return ArticleResponseModel(
        article: Article.fromJson(_result.toJson()),
        paragraphs: _result
            .get<List<RecordModel>>('expand.$_expand')
            .map((p) => ArticleParagraph.fromJson(p.toJson()))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ArticleResponseModel> addParapraphToArticle(
    ArticleParagraph paragraph,
  ) async {
    final _result = await PocketbaseHelper.pb
        .collection(collectionParagraphs)
        .create(body: paragraph.toJson());

    final _articleRef = await PocketbaseHelper.pb
        .collection(collectionArticles)
        .getOne(paragraph.article_id);

    final _article = Article.fromJson(_articleRef.toJson());

    final _update = {
      _expand: [
        ..._article.paragraphs_ids,
        _result.id,
      ],
    };

    final _updateRef =
        await PocketbaseHelper.pb.collection(collectionArticles).update(
              _article.id,
              body: _update,
              expand: _expand,
            );

    return ArticleResponseModel(
      article: Article.fromJson(_updateRef.toJson()),
      paragraphs: _updateRef
          .get<List<RecordModel>>('expand.$_expand')
          .map((p) => ArticleParagraph.fromJson(p.toJson()))
          .toList(),
    );
  }

  Future<void> deleteParagraphFromArticle(String paragraph_id) async {
    await PocketbaseHelper.pb
        .collection(collectionParagraphs)
        .delete(paragraph_id);
  }

  Future<void> deleteArticle(String article_id) async {
    await PocketbaseHelper.pb.collection(collectionArticles).delete(article_id);
  }

  Future<void> updateParagraphData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await PocketbaseHelper.pb.collection(collectionParagraphs).update(
          id,
          body: update,
        );
  }
}
