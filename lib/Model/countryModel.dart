class Country {
  final String name;
  final String capital;
  final String flagUrl;
  final String region;
  final int population;

  Country({
    required this.name,
    required this.capital,
    required this.flagUrl,
    required this.region,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // 1. Extract Name (v5 uses 'names' -> 'common')
    String countryName = 'Unknown Country';
    if (json['names'] is Map && json['names']['common'] != null) {
      countryName = json['names']['common'].toString();
    } else if (json['name'] is Map && json['name']['common'] != null) {
      countryName = json['name']['common'].toString();
    } else if (json['name'] != null) {
      countryName = json['name'].toString();
    }

    // 2. Extract Capital (v5 uses an array of objects: 'capitals' -> [{'name': '...'}] )
    String capitalText = 'No Capital';
    if (json['capitals'] is List && (json['capitals'] as List).isNotEmpty) {
      final firstCapital = json['capitals'][0];
      if (firstCapital is Map && firstCapital['name'] != null) {
        capitalText = firstCapital['name'].toString();
      } else {
        capitalText = firstCapital.toString();
      }
    } else if (json['capital'] is List &&
        (json['capital'] as List).isNotEmpty) {
      capitalText = json['capital'][0].toString();
    }

    // 3. Extract Flag Image URL (v5 uses 'flag' -> 'url_png')
    String flag = '';
    if (json['flag'] is Map && json['flag']['url_png'] != null) {
      flag = json['flag']['url_png'].toString();
    } else if (json['flags'] is Map && json['flags']['png'] != null) {
      flag = json['flags']['png'].toString();
    }

    return Country(
      name: countryName,
      capital: capitalText,
      flagUrl: flag,
      region: (json['region'] ?? 'Unknown Region').toString(),
      population: int.tryParse(json['population'].toString()) ?? 0,
    );
  }
}
