import 'package:equatable/equatable.dart';

class SiteSettings extends Equatable {
  final String id;
  final String doc_id;
  final String? website_background;
  //main
  final String? website_title_font_color;
  final String? website_title_font_shadow_color;
  final int? website_title_font_size_mobile;
  final int? website_title_font_size_other;
  //titles
  final String? titles_font_color;
  final String? titles_font_shadow_color;
  final int? titles_font_size_mobile;
  final int? titles_font_size_other;
  //subtitles
  final String? subtitles_font_color;
  final String? subtitles_font_shadow_color;
  final int? subtitles_font_size_mobile;
  final int? subtitles_font_size_other;
  //text
  final String? text_font_color;
  final String? text_font_shadow_color;
  final int? text_font_size_mobile;
  final int? text_font_size_other;
  //buttons
  final String? button_color;
  final String? button_font_color;

  const SiteSettings({
    required this.id,
    required this.doc_id,
    required this.website_background,
    required this.website_title_font_color,
    required this.website_title_font_shadow_color,
    required this.website_title_font_size_mobile,
    required this.website_title_font_size_other,
    required this.titles_font_color,
    required this.titles_font_shadow_color,
    required this.titles_font_size_mobile,
    required this.titles_font_size_other,
    required this.subtitles_font_color,
    required this.subtitles_font_shadow_color,
    required this.subtitles_font_size_mobile,
    required this.subtitles_font_size_other,
    required this.text_font_color,
    required this.text_font_shadow_color,
    required this.text_font_size_mobile,
    required this.text_font_size_other,
    required this.button_color,
    required this.button_font_color,
  });

  SiteSettings copyWith({
    String? id,
    String? doc_id,
    String? website_background,
    String? website_title_font_color,
    String? website_title_font_shadow_color,
    int? website_title_font_size_mobile,
    int? website_title_font_size_other,
    String? titles_font_color,
    String? titles_font_shadow_color,
    int? titles_font_size_mobile,
    int? titles_font_size_other,
    String? subtitles_font_color,
    String? subtitles_font_shadow_color,
    int? subtitles_font_size_mobile,
    int? subtitles_font_size_other,
    String? text_font_color,
    String? text_font_shadow_color,
    int? text_font_size_mobile,
    int? text_font_size_other,
    String? button_color,
    String? button_font_color,
  }) {
    return SiteSettings(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      website_background: website_background ?? this.website_background,
      website_title_font_color:
          website_title_font_color ?? this.website_title_font_color,
      website_title_font_shadow_color: website_title_font_shadow_color ??
          this.website_title_font_shadow_color,
      website_title_font_size_mobile:
          website_title_font_size_mobile ?? this.website_title_font_size_mobile,
      website_title_font_size_other:
          website_title_font_size_other ?? this.website_title_font_size_other,
      titles_font_color: titles_font_color ?? this.titles_font_color,
      titles_font_shadow_color:
          titles_font_shadow_color ?? this.titles_font_shadow_color,
      titles_font_size_mobile:
          titles_font_size_mobile ?? this.titles_font_size_mobile,
      titles_font_size_other:
          titles_font_size_other ?? this.titles_font_size_other,
      subtitles_font_color: subtitles_font_color ?? this.subtitles_font_color,
      subtitles_font_shadow_color:
          subtitles_font_shadow_color ?? this.subtitles_font_shadow_color,
      subtitles_font_size_mobile:
          subtitles_font_size_mobile ?? this.subtitles_font_size_mobile,
      subtitles_font_size_other:
          subtitles_font_size_other ?? this.subtitles_font_size_other,
      text_font_color: text_font_color ?? this.text_font_color,
      text_font_shadow_color:
          text_font_shadow_color ?? this.text_font_shadow_color,
      text_font_size_mobile:
          text_font_size_mobile ?? this.text_font_size_mobile,
      text_font_size_other: text_font_size_other ?? this.text_font_size_other,
      button_color: button_color ?? this.button_color,
      button_font_color: button_font_color ?? this.button_font_color,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'website_background': website_background,
      'website_title_font_color': website_title_font_color,
      'website_title_font_shadow_color': website_title_font_shadow_color,
      'website_title_font_size_mobile': website_title_font_size_mobile,
      'website_title_font_size_other': website_title_font_size_other,
      'titles_font_color': titles_font_color,
      'titles_font_shadow_color': titles_font_shadow_color,
      'titles_font_size_mobile': titles_font_size_mobile,
      'titles_font_size_other': titles_font_size_other,
      'subtitles_font_color': subtitles_font_color,
      'subtitles_font_shadow_color': subtitles_font_shadow_color,
      'subtitles_font_size_mobile': subtitles_font_size_mobile,
      'subtitles_font_size_other': subtitles_font_size_other,
      'text_font_color': text_font_color,
      'text_font_shadow_color': text_font_shadow_color,
      'text_font_size_mobile': text_font_size_mobile,
      'text_font_size_other': text_font_size_other,
      'button_color': button_color,
      'button_font_color': button_font_color,
    };
  }

  factory SiteSettings.fromJson(Map<String, dynamic> map) {
    return SiteSettings(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      website_background: map['website_background'] as String?,
      website_title_font_color: map['website_title_font_color'] as String?,
      website_title_font_shadow_color:
          map['website_title_font_shadow_color'] as String?,
      website_title_font_size_mobile:
          map['website_title_font_size_mobile'] as int?,
      website_title_font_size_other:
          map['website_title_font_size_other'] as int?,
      titles_font_color: map['titles_font_color'] as String?,
      titles_font_shadow_color: map['titles_font_shadow_color'] as String?,
      titles_font_size_mobile: map['titles_font_size_mobile'] as int?,
      titles_font_size_other: map['titles_font_size_other'] as int?,
      subtitles_font_color: map['subtitles_font_color'] as String?,
      subtitles_font_shadow_color:
          map['subtitles_font_shadow_color'] as String?,
      subtitles_font_size_mobile: map['subtitles_font_size_mobile'] as int?,
      subtitles_font_size_other: map['subtitles_font_size_other'] as int?,
      text_font_color: map['text_font_color'] as String?,
      text_font_shadow_color: map['text_font_shadow_color'] as String?,
      text_font_size_mobile: map['text_font_size_mobile'] as int?,
      text_font_size_other: map['text_font_size_other'] as int?,
      button_color: map['button_color'] as String?,
      button_font_color: map['button_font_color'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      website_background,
      website_title_font_color,
      website_title_font_shadow_color,
      website_title_font_size_mobile,
      website_title_font_size_other,
      titles_font_color,
      titles_font_shadow_color,
      titles_font_size_mobile,
      titles_font_size_other,
      subtitles_font_color,
      subtitles_font_shadow_color,
      subtitles_font_size_mobile,
      subtitles_font_size_other,
      text_font_color,
      text_font_shadow_color,
      text_font_size_mobile,
      text_font_size_other,
      button_color,
      button_font_color,
    ];
  }

  static List<String> forWidgetsJson() => [
        'website_background',
        'website_title_font_color',
        'website_title_font_shadow_color',
        'website_title_font_size_mobile',
        'website_title_font_size_other',
        'titles_font_color',
        'titles_font_shadow_color',
        'titles_font_size_mobile',
        'titles_font_size_other',
        'subtitles_font_color',
        'subtitles_font_shadow_color',
        'subtitles_font_size_mobile',
        'subtitles_font_size_other',
        'text_font_color',
        'text_font_shadow_color',
        'text_font_size_mobile',
        'text_font_size_other',
        'button_color',
        'button_font_color',
      ];
}
