import 'package:translator/translator.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class GeneralUtil {
  Future translateToInd(String value) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(value, to: 'id');
    return translation.text.toString();
  }

  String dateConvert(int value) {
    switch (value) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return 'Err';
    }
  }

  String encryptAES(String plain) {
    final String plainText = plain;
    final encrypt.Key key =
        encrypt.Key.fromUtf8('MobileSecret1234BFIMajuTerus2020');
    final encrypt.IV iv = encrypt.IV.fromUtf8('MobileSecret1234');

    final encrypt.Encrypter encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    final encrypt.Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }
}
