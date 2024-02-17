/*

In Flutter's Google Maps plugin, you can customize the appearance of the map using map styles.
Map styles allow you to change the visual appearance of various map elements,
such as roads, parks, water bodies, and more. Here's how you can apply styles to a 
Google Map in Flutter:
1-to Appling google map style you first must define the json of the style that you want to appling on the map
2- then when the map created , you will pass the style json that you want to the Google map
onMapCreated: (GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  },


////// IMPORTANT :-
------------------
TO CREATE AN STYLE THERE ARE TWO WAYS :-
  1- FRIST WAY USING GOOGLE MAPS PLATFPRM FROM STYLES TABS IN SIDE MENU URL :- https://console.cloud.google.com/google/maps-apis/studio/styles?pli=1&project=MYPROJECT 
  2- FROM MAPS STYLE WIZARED URL :- https://mapstyle.withgoogle.com/ .

*/

Map<String, String> mapsStyles = {
  "nightModeStyle": nightModeStyle,
  "retroStyle": retroStyle,
  "grayscaleStyle": grayscaleStyle,
  "customStyle": customStyle
};

String nightModeStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]
''';

String retroStyle = '''
[
  {
    "featureType": "all",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "saturation": 36
      },
      {
        "color": "#000000"
      },
      {
        "lightness": 40
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#000000"
      },
      {
        "lightness": 17
      },
      {
        "weight": 1.2
      }
    ]
  },
  {
    "featureType": "landscape",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      },
      {
        "lightness": 20
      }
    ]
  }
]
''';

String grayscaleStyle = '''
[
  {
    "featureType": "all",
    "elementType": "all",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "gamma": 0.5
      }
    ]
  }
]
''';

String customStyle = '''
[
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#86A6DF"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#FF8C00"
      }
    ]
  }
]
''';
