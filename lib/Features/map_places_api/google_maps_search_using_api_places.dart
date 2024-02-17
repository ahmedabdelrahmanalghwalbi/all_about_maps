import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_webservice/places.dart';

class GoogleMapsSearchUsingApiPlacesAndWebServicesPackage
    extends StatefulWidget {
  const GoogleMapsSearchUsingApiPlacesAndWebServicesPackage({super.key});

  @override
  State<GoogleMapsSearchUsingApiPlacesAndWebServicesPackage> createState() =>
      _GoogleMapsSearchUsingApiPlacesAndWebServicesPackageState();
}

class _GoogleMapsSearchUsingApiPlacesAndWebServicesPackageState
    extends State<GoogleMapsSearchUsingApiPlacesAndWebServicesPackage> {
  TextEditingController searchController = TextEditingController();
  GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']);
  List<PlacesSearchResult> _searchResults = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Enter search text',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
              onSubmitted: (value) {
                _performSearch();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<PlacesSearchResult>>(
              future:
                  _searchResults.isEmpty ? null : Future.value(_searchResults),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No results found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      PlacesSearchResult result = snapshot.data![index];
                      return ListTile(
                        title: Text(result.name),
                        subtitle: Text(result.formattedAddress ?? ''),
                        onTap: () {
                          // Handle tile tap
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performSearch() async {
    final response = await places.searchByText(searchController.text);
    if (response.errorMessage == null) {
      setState(() {
        _searchResults = response.results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
      debugPrint('Error searching: ${response.errorMessage}');
    }
  }
}
