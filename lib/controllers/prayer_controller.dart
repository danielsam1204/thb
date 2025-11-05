import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PrayerController extends GetxController implements GetxService {
  List<dynamic> _prayerList = [];
  bool _showForm = false;

  List<dynamic> get prayerList => _prayerList;

  bool get showForm => _showForm;

  void onChangeShowForm(bool val) {
    _showForm = val;
    update();
  }

  initCall(){
    _showForm = false;
  }
}
