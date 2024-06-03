import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';

import '../helper/basehelper.dart';

class GooglePlaces {
  static Future<String?> googlePlaccesLoc(context) async {
    String? place;
    void onError(response) {
      BaseHelper.showSnackBar(
          context, response.errorMessage ?? 'Unknown error');
      return;
    }

    await PlacesAutocomplete.show(
      context: context,
      apiKey: BaseHelper.kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay, // or Mode.fullscreen

      components: [
        const Component(Component.country, 'Pk'),
        const Component(Component.country, 'it')
      ],
    ).then((value) {
      if (value != null) {
        return place = value.description;
      }
      return null;
    });
    return place.toString();
  }
}
