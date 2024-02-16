/*
GEOCODING :-
------------
Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates 
(like latitude 37.423021 and longitude -122.083739), which you can use to place markers on a map, or position the map.

In Flutter, you can perform geocoding using the geocoding package, which provides APIs for both forward and reverse geocoding.

1. Forward Geocoding:
--------------------
Forward geocoding is the process of converting an address (or place name) into geographic coordinates.

Example:

    import 'package:geocoding/geocoding.dart';
      List<Location> locations = await locationFromAddress('1600 Amphitheatre Parkway, Mountain View, CA');
      Location first = locations.first;
      print("Latitude: ${first.latitude}, Longitude: ${first.longitude}");

2. Reverse Geocoding:
---------------------
Reverse geocoding is the process of converting geographic coordinates into an address.

Example:

    import 'package:geocoding/geocoding.dart';
      List<Placemark> placemarks = await placemarkFromCoordinates(37.423021, -122.083739);
      Placemark first = placemarks.first;
      print("${first.street}, ${first.locality}, ${first.administrativeArea} ${first.postalCode}, ${first.country}");



Additional Features and Considerations :
----------------------------------------
1- Error Handling: Ensure to handle errors appropriately, as network requests and geocoding operations may fail due to various reasons such as
network connectivity issues or invalid addresses.

2- Multiple Results: Both forward and reverse geocoding operations may return multiple results. For example, an address may have multiple 
potential coordinates, or a set of coordinates may correspond to multiple addresses. Always handle multiple results appropriately based on your application's requirements.

3- API Key: Depending on the geocoding service provider you use, you may need to obtain an API key and configure it in your application.
For example, if you use the Google Maps Platform for geocoding, you'll need to obtain an API key and include it in your API requests.

4- Rate Limits: Be aware of any rate limits imposed by the geocoding service provider. Exceeding rate limits may result in errors or 
temporary blocking of your application's access to the geocoding service.

5- Localization: Consider the localization of addresses returned by reverse geocoding. Address formats and language may vary depending on
the country or region. Some geocoding services allow you to specify language preferences for address results.

6- By utilizing forward and reverse geocoding in your Flutter application, you can incorporate address lookup and location-based features,
such as displaying addresses on maps, searching for nearby places, and more.
Always ensure to handle errors and consider the specific requirements and limitations of the geocoding service provider you choose to use.

*/