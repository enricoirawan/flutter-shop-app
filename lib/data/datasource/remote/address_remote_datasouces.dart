import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../common/helper.dart';

abstract class AddressRemoteDataSources {
  const AddressRemoteDataSources();

  Future<String> getUserPosition();
}

class AddressRemoteDataSourcesImpl implements AddressRemoteDataSources {
  @override
  Future<String> getUserPosition() async {
    try {
      Position position = await determinePosition();

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark result = placemarks[0];
      String? street = result.street;
      String? administrativeArea = result.administrativeArea;
      String? subAdministrativeArea = result.subAdministrativeArea;

      return "$street, $subAdministrativeArea, $administrativeArea";
    } catch (e) {
      rethrow;
    }
  }
}
