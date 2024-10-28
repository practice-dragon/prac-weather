import 'package:geolocator/geolocator.dart';
import 'package:prac/screens/loading.dart';

class MyLocation {
  late double latitude2;
  late double longitude2;

  Future<void> getMyCurrentLocation() async {
    try {
      // await을 사용하지 않고 Future<LocationPermission>를 사용하게 되면 처음 실행될 때 이 빈 인스턴스로 초기화됨.
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition();
      flutterToast(position.toString());

      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
    } catch (e) {
      flutterToast('There was a problem with the internet connection');
    }
  }
}
