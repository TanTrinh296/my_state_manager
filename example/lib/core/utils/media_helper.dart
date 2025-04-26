import 'package:image_picker/image_picker.dart';

class MediaHelper {
  Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) async {
    return await ImagePicker().pickImage(source: source);
  }
}
