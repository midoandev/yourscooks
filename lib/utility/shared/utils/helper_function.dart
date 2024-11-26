import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class HelperFunction {

  isIos() {
    // print('platfrom ${GetPlatform().toString()}');
    if (GetPlatform.isIOS) {
      return true;
    }
    return false;
  }

  static void copyToClipboard(String text) {
    final textarea = html.TextAreaElement();
    html.document.body?.append(textarea);
    textarea.style.position = 'fixed';
    textarea.style.left = '-9999px';
    textarea.value = text;
    textarea.select();
    html.document.execCommand('copy');
    textarea.remove();
  }

  static void showToast(String message) {
    var toast = html.DivElement();
    toast.text = message;
    var sty = toast.style;
    sty.position = 'fixed';
    sty.bottom = '16px';
    sty.left = '50%';
    sty.transform = 'translateX(-50%)';
    sty.padding = '12px 24px';
    sty.backgroundColor = '#333';
    sty.color = '#fff';
    sty.borderRadius = '4px';
    sty.zIndex = '9999';

    html.document.body?.append(toast);

    Future.delayed(const Duration(seconds: 2), () {
      toast.remove();
    });
  }


  static bool browserIsChrome() {
    if (GetPlatform.isIOS) {
      // print('Website dibuka di Safari');
      return false;
      // Tambahkan logika khusus untuk Safari di sini
    } else {
      // print('Website dibuka di browser lain');
      return true;
      // Tambahkan logika untuk browser lain di sini
    }
  }


}
