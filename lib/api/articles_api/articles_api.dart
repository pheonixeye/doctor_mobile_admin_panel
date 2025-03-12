import 'dart:typed_data';

import 'package:doctor_mobile_admin_panel/api/common.dart';
import 'package:doctor_mobile_admin_panel/api/profile_api/profile_api.dart';
import 'package:doctor_mobile_admin_panel/extensions/annotations.dart';
import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/models/article_paragraph.dart';
import 'package:doctor_mobile_admin_panel/models/article_response_model.dart';
import 'package:doctor_mobile_admin_panel/models/doctor.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ArticlesApi {
  const ArticlesApi();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<List<ArticleResponseModel>> fetchArticlesOfOneDoctor();

  Future<ArticleResponseModel> AddNewArticle(Article article);

  Future<void> updateArticleData(String id, Map<String, dynamic> update);

  Future<void> updateArticleThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  });

  Future<void> addParapraphToArticle(ArticleParagraph paragraph);

  Future<void> deleteParagraphFromArticle(String paragraph_id);

  Future<void> deleteArticle(String article_id);

  Future<void> updateParagraphData(String id, Map<String, dynamic> update);

  factory ArticlesApi.common({required String doc_id}) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxArticlesPocketbase(doc_id: doc_id),
      DataSource.sb => HxArticlesSupabase(doc_id: doc_id),
    };
  }
}

@POCKETBASE()
class HxArticlesPocketbase extends ArticlesApi {
  HxArticlesPocketbase({required this.doc_id});

  final String doc_id;

  static const String collectionArticles = 'articles';

  static const String collectionParagraphs = 'articles_paragraphs';

  static const String _expand = 'paragraphs_ids';

  final _client = (DataSourceHelper.ds as PocketBase);

  @override
  Future<List<ArticleResponseModel>> fetchArticlesOfOneDoctor() async {
    final _result = await _client.collection(collectionArticles).getFullList(
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

  @override
  Future<ArticleResponseModel> AddNewArticle(Article article) async {
    final _result = await _client.collection(collectionArticles).create(
          body: article.toJson(),
          expand: _expand,
        );

    final _docRef =
        await _client.collection(HxProfilePocketbase.collection).getOne(doc_id);

    final _doctor = Doctor.fromJson(_docRef.toJson());

    final _update = {
      'article_ids': [
        ..._doctor.article_ids ?? [],
        _result.id,
      ],
    };

    await _client.collection(HxProfilePocketbase.collection).update(
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

  @override
  Future<ArticleResponseModel> updateArticleData(
      String id, Map<String, dynamic> update) async {
    final _result = await _client.collection(collectionArticles).update(
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

  @override
  Future<ArticleResponseModel> updateArticleThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    try {
      final _result = await _client.collection(collectionArticles).update(id,
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

  @override
  Future<ArticleResponseModel> addParapraphToArticle(
    ArticleParagraph paragraph,
  ) async {
    final _result = await _client
        .collection(collectionParagraphs)
        .create(body: paragraph.toJson());

    final _articleRef = await _client
        .collection(collectionArticles)
        .getOne(paragraph.article_id);

    final _article = Article.fromJson(_articleRef.toJson());

    final _update = {
      _expand: [
        ..._article.paragraphs_ids ?? [],
        _result.id,
      ],
    };

    final _updateRef = await _client.collection(collectionArticles).update(
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

  @override
  Future<void> deleteParagraphFromArticle(String paragraph_id) async {
    await _client.collection(collectionParagraphs).delete(paragraph_id);
  }

  @override
  Future<void> deleteArticle(String article_id) async {
    await _client.collection(collectionArticles).delete(article_id);
  }

  @override
  Future<void> updateParagraphData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await _client.collection(collectionParagraphs).update(
          id,
          body: update,
        );
  }
}

@SUPABASE()
class HxArticlesSupabase extends ArticlesApi {
  final String doc_id;

  static const String articlesCollection = 'articles';

  static const String paragraphsCollection = 'articles_paragraphs';

  final _client = (DataSourceHelper.ds as SupabaseClient);

  HxArticlesSupabase({required this.doc_id});
  @override
  Future<ArticleResponseModel> AddNewArticle(Article article) async {
    final _result = await _client
        .from(articlesCollection)
        .insert(article.toSupabaseJson())
        .select();

    final _article = Article.fromJson(_result.first);

    return ArticleResponseModel(
      article: _article,
      paragraphs: [],
    );
  }

  @override
  Future<void> addParapraphToArticle(
    ArticleParagraph paragraph,
  ) async {
    await _client.from(paragraphsCollection).insert(paragraph.toSupabaseJson());
  }

  @override
  Future<void> deleteArticle(String article_id) async {
    await _client.from(articlesCollection).delete().eq('id', article_id);
  }

  @override
  Future<void> deleteParagraphFromArticle(String paragraph_id) async {
    await _client.from(paragraphsCollection).delete().eq('id', paragraph_id);
  }

  @override
  Future<List<ArticleResponseModel>> fetchArticlesOfOneDoctor() async {
    final rpc = 'get_articles';

    final _params = {'doctor_id': doc_id};

    final _result = await _client.rpc(rpc, params: _params).select();

    return _result.map((x) {
      return ArticleResponseModel(
        article: Article.fromJson(x),
        paragraphs: x['paragraphs'] == null
            ? []
            : (x['paragraphs'] as List<dynamic>)
                .map((y) => ArticleParagraph.fromJson(y))
                .toList(),
      );
    }).toList();
  }

  @override
  Future<void> updateArticleData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await _client.from(articlesCollection).update(update).eq('id', id);
  }

  @override
  Future<void> updateArticleThumbnail({
    required String id,
    required List<int> fileBytes,
    required String fileName_key,
  }) async {
    final _data = Uint8List.fromList(fileBytes);
    // final _file = File.fromRawPath(_data);
    //TODO: change for mobile
    final result = await _client.storage.from('base').uploadBinary(
          '$doc_id/$articlesCollection/$id/$fileName_key',
          _data,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ),
        );

    String _pathDebased = result.replaceFirstMapped('base/', (m) => '');

    final _update = {
      'thumbnail': _pathDebased,
    };

    await _client.from(articlesCollection).update(_update).eq('id', id);
  }

  @override
  Future<void> updateParagraphData(
    String id,
    Map<String, dynamic> update,
  ) async {
    await _client.from(paragraphsCollection).update(update).eq('id', id);
  }
}
