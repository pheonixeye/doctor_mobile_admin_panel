import 'package:doctor_mobile_admin_panel/providers/locale_p.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => PxLocale(),
  ),
];
