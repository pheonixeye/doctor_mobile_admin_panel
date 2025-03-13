import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:flutter/widgets.dart';

extension ForWidgets on HeroItem {
  Map<String, String> titleOptions(BuildContext context) {
    return {
      'title_en': context.loc.englishHeroTitle,
      'title_ar': context.loc.arabicHeroTitle,
      't_font_mobile': context.loc.fontMobile,
      't_font_other': context.loc.fontOther,
      't_align': context.loc.align,
      't_top_mobile': context.loc.spacingTopMobile,
      't_start_mobile': context.loc.spacingStartMobile,
      't_top_other': context.loc.spacingTopOther,
      't_start_other': context.loc.spacingStartOther,
    };
  }

  Map<String, String> subtitleOptions(BuildContext context) {
    return {
      'subtitle_en': context.loc.englishHeroSubtitle,
      'subtitle_ar': context.loc.arabicHeroSubtitle,
      's_font_mobile': context.loc.fontMobile,
      's_font_other': context.loc.fontOther,
      's_align': context.loc.align,
      's_top_mobile': context.loc.spacingTopMobile,
      's_start_mobile': context.loc.spacingStartMobile,
      's_top_other': context.loc.spacingTopOther,
      's_start_other': context.loc.spacingStartOther,
    };
  }

  Map<String, String> descriptionOptions(BuildContext context) {
    return {
      'description_en': context.loc.englishHeroDescription,
      'description_ar': context.loc.arabicHeroDescription,
      'd_font_mobile': context.loc.fontMobile,
      'd_font_other': context.loc.fontOther,
      'd_align': context.loc.align,
      'd_top_mobile': context.loc.spacingTopMobile,
      'd_start_mobile': context.loc.spacingStartMobile,
      'd_top_other': context.loc.spacingTopOther,
      'd_start_other': context.loc.spacingStartOther,
    };
  }
}
