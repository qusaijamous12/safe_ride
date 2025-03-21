import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapController extends GetxController{

  final _myPosition=Rxn<Position>(null);

  @override
  void onInit() async{
    _myPosition(await determinePosition());
    super.onInit();
  }


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }


  Position ?get myPosition=>_myPosition.value;

}