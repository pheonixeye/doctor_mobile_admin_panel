import 'package:equatable/equatable.dart';

class HeroItem extends Equatable {
  final String id;
  final String doc_id;
  final String? image_mobile;
  final String? image_other;
  final String title_en;
  final String title_ar;
  final String? subtitle_en;
  final String? subtitle_ar;
  final String? description_en;
  final String? description_ar;
  final int? t_font_mobile;
  final int? t_font_other;
  final int? s_font_mobile;
  final int? s_font_other;
  final int? d_font_mobile;
  final int? d_font_other;
  final String? t_align;
  final String? s_align;
  final String? d_align;
  final int? t_top_mobile;
  final int? t_start_mobile;
  final int? t_top_other;
  final int? t_start_other;
  final int? s_top_mobile;
  final int? s_start_mobile;
  final int? s_top_other;
  final int? s_start_other;
  final int? d_top_mobile;
  final int? d_start_mobile;
  final int? d_top_other;
  final int? d_start_other;
  const HeroItem({
    required this.id,
    required this.doc_id,
    this.image_mobile,
    this.image_other,
    required this.title_en,
    required this.title_ar,
    this.subtitle_en,
    this.subtitle_ar,
    this.description_en,
    this.description_ar,
    this.t_font_mobile,
    this.t_font_other,
    this.s_font_mobile,
    this.s_font_other,
    this.d_font_mobile,
    this.d_font_other,
    this.t_align,
    this.s_align,
    this.d_align,
    this.t_top_mobile,
    this.t_start_mobile,
    this.t_top_other,
    this.t_start_other,
    this.s_top_mobile,
    this.s_start_mobile,
    this.s_top_other,
    this.s_start_other,
    this.d_top_mobile,
    this.d_start_mobile,
    this.d_top_other,
    this.d_start_other,
  });

  HeroItem copyWith({
    String? id,
    String? doc_id,
    String? image_mobile,
    String? image_other,
    String? title_en,
    String? title_ar,
    String? subtitle_en,
    String? subtitle_ar,
    String? description_en,
    String? description_ar,
    int? t_font_mobile,
    int? t_font_other,
    int? s_font_mobile,
    int? s_font_other,
    int? d_font_mobile,
    int? d_font_other,
    String? t_align,
    String? s_align,
    String? d_align,
    int? t_top_mobile,
    int? t_start_mobile,
    int? t_top_other,
    int? t_start_other,
    int? s_top_mobile,
    int? s_start_mobile,
    int? s_top_other,
    int? s_start_other,
    int? d_top_mobile,
    int? d_start_mobile,
    int? d_top_other,
    int? d_start_other,
  }) {
    return HeroItem(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      image_mobile: image_mobile ?? this.image_mobile,
      image_other: image_other ?? this.image_other,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      subtitle_en: subtitle_en ?? this.subtitle_en,
      subtitle_ar: subtitle_ar ?? this.subtitle_ar,
      description_en: description_en ?? this.description_en,
      description_ar: description_ar ?? this.description_ar,
      t_font_mobile: t_font_mobile ?? this.t_font_mobile,
      t_font_other: t_font_other ?? this.t_font_other,
      s_font_mobile: s_font_mobile ?? this.s_font_mobile,
      s_font_other: s_font_other ?? this.s_font_other,
      d_font_mobile: d_font_mobile ?? this.d_font_mobile,
      d_font_other: d_font_other ?? this.d_font_other,
      t_align: t_align ?? this.t_align,
      s_align: s_align ?? this.s_align,
      d_align: d_align ?? this.d_align,
      t_top_mobile: t_top_mobile ?? this.t_top_mobile,
      t_start_mobile: t_start_mobile ?? this.t_start_mobile,
      t_top_other: t_top_other ?? this.t_top_other,
      t_start_other: t_start_other ?? this.t_start_other,
      s_top_mobile: s_top_mobile ?? this.s_top_mobile,
      s_start_mobile: s_start_mobile ?? this.s_start_mobile,
      s_top_other: s_top_other ?? this.s_top_other,
      s_start_other: s_start_other ?? this.s_start_other,
      d_top_mobile: d_top_mobile ?? this.d_top_mobile,
      d_start_mobile: d_start_mobile ?? this.d_start_mobile,
      d_top_other: d_top_other ?? this.d_top_other,
      d_start_other: d_start_other ?? this.d_start_other,
    );
  }

  HeroText get title => HeroText(
        text_en: title_en,
        text_ar: title_ar,
        align: t_align,
        font_mobile: t_font_mobile,
        font_other: t_font_other,
        top_mobile: t_top_mobile,
        top_other: t_top_other,
        start_mobile: t_start_mobile,
        start_other: t_start_other,
      );

  HeroText get subtitle => HeroText(
        text_en: subtitle_en,
        text_ar: subtitle_ar,
        align: s_align,
        font_mobile: s_font_mobile,
        font_other: s_font_other,
        top_mobile: s_top_mobile,
        top_other: s_top_other,
        start_mobile: s_start_mobile,
        start_other: s_start_other,
      );

  HeroText get description => HeroText(
        text_en: description_en,
        text_ar: description_ar,
        align: d_align,
        font_mobile: d_font_mobile,
        font_other: d_font_other,
        top_mobile: d_top_mobile,
        top_other: d_top_other,
        start_mobile: d_start_mobile,
        start_other: d_start_other,
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'image_mobile': image_mobile,
      'image_other': image_other,
      'title_en': title_en,
      'title_ar': title_ar,
      'subtitle_en': subtitle_en,
      'subtitle_ar': subtitle_ar,
      'description_en': description_en,
      'description_ar': description_ar,
      't_font_mobile': t_font_mobile,
      't_font_other': t_font_other,
      's_font_mobile': s_font_mobile,
      's_font_other': s_font_other,
      'd_font_mobile': d_font_mobile,
      'd_font_other': d_font_other,
      't_align': t_align,
      's_align': s_align,
      'd_align': d_align,
      't_top_mobile': t_top_mobile,
      't_start_mobile': t_start_mobile,
      't_top_other': t_top_other,
      't_start_other': t_start_other,
      's_top_mobile': s_top_mobile,
      's_start_mobile': s_start_mobile,
      's_top_other': s_top_other,
      's_start_other': s_start_other,
      'd_top_mobile': d_top_mobile,
      'd_start_mobile': d_start_mobile,
      'd_top_other': d_top_other,
      'd_start_other': d_start_other,
    };
  }

  Map<String, dynamic> toSupabaseJson() => toJson()..remove('id');

  factory HeroItem.fromJson(Map<String, dynamic> map) {
    return HeroItem(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      image_mobile: map['image_mobile'] as String?,
      image_other: map['image_other'] as String?,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      subtitle_en:
          map['subtitle_en'] != null ? map['subtitle_en'] as String : null,
      subtitle_ar:
          map['subtitle_ar'] != null ? map['subtitle_ar'] as String : null,
      description_en: map['description_en'] != null
          ? map['description_en'] as String
          : null,
      description_ar: map['description_ar'] != null
          ? map['description_ar'] as String
          : null,
      t_font_mobile:
          map['t_font_mobile'] != null ? map['t_font_mobile'] as int : null,
      t_font_other:
          map['t_font_other'] != null ? map['t_font_other'] as int : null,
      s_font_mobile:
          map['s_font_mobile'] != null ? map['s_font_mobile'] as int : null,
      s_font_other:
          map['s_font_other'] != null ? map['s_font_other'] as int : null,
      d_font_mobile:
          map['d_font_mobile'] != null ? map['d_font_mobile'] as int : null,
      d_font_other:
          map['d_font_other'] != null ? map['d_font_other'] as int : null,
      t_align: map['t_align'] != null ? map['t_align'] as String : null,
      s_align: map['s_align'] != null ? map['s_align'] as String : null,
      d_align: map['d_align'] != null ? map['d_align'] as String : null,
      t_top_mobile:
          map['t_top_mobile'] != null ? map['t_top_mobile'] as int : null,
      t_start_mobile:
          map['t_start_mobile'] != null ? map['t_start_mobile'] as int : null,
      t_top_other:
          map['t_top_other'] != null ? map['t_top_other'] as int : null,
      t_start_other:
          map['t_start_other'] != null ? map['t_start_other'] as int : null,
      s_top_mobile:
          map['s_top_mobile'] != null ? map['s_top_mobile'] as int : null,
      s_start_mobile:
          map['s_start_mobile'] != null ? map['s_start_mobile'] as int : null,
      s_top_other:
          map['s_top_other'] != null ? map['s_top_other'] as int : null,
      s_start_other:
          map['s_start_other'] != null ? map['s_start_other'] as int : null,
      d_top_mobile:
          map['d_top_mobile'] != null ? map['d_top_mobile'] as int : null,
      d_start_mobile:
          map['d_start_mobile'] != null ? map['d_start_mobile'] as int : null,
      d_top_other:
          map['d_top_other'] != null ? map['d_top_other'] as int : null,
      d_start_other:
          map['d_start_other'] != null ? map['d_start_other'] as int : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      image_mobile,
      image_other,
      title_en,
      title_ar,
      subtitle_en,
      subtitle_ar,
      description_en,
      description_ar,
      t_font_mobile,
      t_font_other,
      s_font_mobile,
      s_font_other,
      d_font_mobile,
      d_font_other,
      t_align,
      s_align,
      d_align,
      t_top_mobile,
      t_start_mobile,
      t_top_other,
      t_start_other,
      s_top_mobile,
      s_start_mobile,
      s_top_other,
      s_start_other,
      d_top_mobile,
      d_start_mobile,
      d_top_other,
      d_start_other,
    ];
  }
}

class HeroText extends Equatable {
  final String? text_en;
  final String? text_ar;
  final String? align;
  final int? font_mobile;
  final int? font_other;
  final int? top_mobile;
  final int? top_other;
  final int? start_mobile;
  final int? start_other;

  const HeroText({
    required this.text_en,
    required this.text_ar,
    required this.align,
    required this.font_mobile,
    required this.font_other,
    required this.top_mobile,
    required this.start_mobile,
    required this.top_other,
    required this.start_other,
  });

  @override
  List<Object?> get props {
    return [
      text_en,
      text_ar,
      align,
      font_mobile,
      font_other,
      top_mobile,
      top_other,
      start_mobile,
      start_other,
    ];
  }
}
