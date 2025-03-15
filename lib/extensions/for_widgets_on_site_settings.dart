import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/models/site_settings.dart';
import 'package:flutter/material.dart';

extension ForWidgetsOnSiteSettings on SiteSettings {
  Map<String, String> websiteTitleSettings(BuildContext context) {
    return {
      'website_title_font_color': context.loc.websiteTitleFontColor,
      'website_title_font_shadow_color':
          context.loc.websiteTitleFontShadowColor,
      'website_title_font_size_mobile': context.loc.websiteTitleFontSizeMobile,
      'website_title_font_size_other': context.loc.websiteTitleFontSizeOther,
    };
  }

  Map<String, String> titlesSettings(BuildContext context) {
    return {
      'titles_font_color': context.loc.titlesFontColor,
      'titles_font_shadow_color': context.loc.titlesFontShadowColor,
      'titles_font_size_mobile': context.loc.titlesFontSizeMobile,
      'titles_font_size_other': context.loc.titlesFontSizeOther,
    };
  }

  Map<String, String> subtitlesSettings(BuildContext context) {
    return {
      'subtitles_font_color': context.loc.subtitlesFontColor,
      'subtitles_font_shadow_color': context.loc.subtitlesFontShadowColor,
      'subtitles_font_size_mobile': context.loc.subtitlesFontSizeMobile,
      'subtitles_font_size_other': context.loc.subtitlesFontSizeOther,
    };
  }

  Map<String, String> textSettings(BuildContext context) {
    return {
      'text_font_color': context.loc.textFontColor,
      'text_font_shadow_color': context.loc.textFontShadowColor,
      'text_font_size_mobile': context.loc.textFontSizeMobile,
      'text_font_size_other': context.loc.textFontSizeOther,
    };
  }

  Map<String, String> buttonSettings(BuildContext context) {
    return {
      'button_color': context.loc.buttonColor,
      'button_font_color': context.loc.buttonFontColor,
    };
  }
}
