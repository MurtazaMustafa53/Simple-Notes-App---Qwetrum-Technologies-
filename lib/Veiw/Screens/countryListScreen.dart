import 'package:flutter/material.dart';
import 'package:staticnotes/Controller/api_Controller.dart';
import 'package:staticnotes/Model/countryModel.dart';


class Countrylistscreen extends StatefulWidget {
  const Countrylistscreen({super.key});

  @override
  State<Countrylistscreen> createState() => _CountrylistscreenState();
}

class _CountrylistscreenState extends State<Countrylistscreen> {
  final ApiController _apiController = ApiController();
  final TextEditingController _searchController = TextEditingController();

  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = true;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    _loadCountriesData();
  }

  Future<void> _loadCountriesData() async {
    try {
      List<Country> fetchedList = await _apiController.fetchCountries();
      setState(() {
        _countries = fetchedList;
        _filteredCountries = fetchedList;
        _isLoading = false;
        print("Countries Loaded");
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = _countries;
      } else {
        _filteredCountries = _countries
            .where(
              (country) =>
                  country.name.toLowerCase().contains(query.toLowerCase()) ||
                  country.capital.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Countries"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.lightBlue))
          : _errorMessage.isNotEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Error: $_errorMessage",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterCountries, //
                    decoration: InputDecoration(
                      labelText: 'Search country or capital...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = _filteredCountries[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: country.flagUrl.isNotEmpty
                              ? Image.network(
                                  country.flagUrl,
                                  width: 50,
                                  height: 35,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, StackTrace) =>
                                      Icon(Icons.flag),
                                )
                              : Icon(Icons.flag),
                          title: Text(
                            country.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Capital: ${country.capital}"),
                          trailing: Text(country.region),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
