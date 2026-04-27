import '../apppackages.dart';

class Hmacs {
  static String hmacSignature(String message, String pass) {
    try {
      List<int> messageBytes = utf8.encode(message);
      List<int> key = utf8.encode(pass);
      Hmac hmac = Hmac(sha512, key);
      Digest digest = hmac.convert(messageBytes);
      String base64Mac = digest.toString();
      return base64Mac;
    } catch (error) {
      rethrow;
    }
  }
}
