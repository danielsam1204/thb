import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController implements GetxService {
  String? profileImage;

  Future<void> pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      profileImage = pickedImage.path;
      print("Picked image: ${pickedImage.path}");
    } else {
      print("No image selected");
    }
    update();
  }
}
