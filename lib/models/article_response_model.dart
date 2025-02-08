// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/models/article_paragraph.dart';

class ArticleResponseModel extends Equatable {
  final Article article;
  final List<ArticleParagraph> paragraphs;

  const ArticleResponseModel({
    required this.article,
    required this.paragraphs,
  });

  ArticleResponseModel copyWith({
    Article? article,
    List<ArticleParagraph>? paragraphs,
  }) {
    return ArticleResponseModel(
      article: article ?? this.article,
      paragraphs: paragraphs ?? this.paragraphs,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'article': article.toJson(),
      'paragraphs': paragraphs.map((x) => x.toJson()).toList(),
    };
  }

  factory ArticleResponseModel.fromJson(Map<String, dynamic> map) {
    return ArticleResponseModel(
      article: Article.fromJson(map['article'] as Map<String, dynamic>),
      paragraphs: List<ArticleParagraph>.from(
        (map['paragraphs'] as List<dynamic>).map<ArticleParagraph>(
          (x) => ArticleParagraph.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        article,
        paragraphs,
      ];
}
