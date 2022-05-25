import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:share_plus/share_plus.dart';

class AboutViewModel extends BaseViewModel {
  shareAbout() async {
    Share.share('https://ciwalk.com/about');
  }
}
