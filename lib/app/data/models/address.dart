// ignore_for_file: non_constant_identifier_names
typedef Coord = (double lat, double lng);

class Address {
  final int id;
  final String CEP;
  final String addressLine;
  final int? number;
  final String? additionalInfo;
  final Coord? coordinates;

  Address({
    this.id = -1,
    required this.CEP,
    required this.addressLine,
    this.number,
    this.additionalInfo,
    this.coordinates,
  });

  String get formattedCEP {
    final regExp = RegExp(r'(\d{5})(\d{3})');
    return CEP.replaceAllMapped(regExp, (match) => '${match[1]}-${match[2]}');
  }

  Address withNumber(int? number) {
    return Address(
      id: id,
      CEP: CEP,
      addressLine: addressLine,
      number: number,
      additionalInfo: additionalInfo,
      coordinates: coordinates,
    );
  }

  Address withAdditionalInfo(String? additionalInfo) {
    return Address(
      id: id,
      CEP: CEP,
      addressLine: addressLine,
      number: number,
      additionalInfo: additionalInfo,
      coordinates: coordinates,
    );
  }

  Map<String, dynamic> toDBMap() {
    return {
      'CEP': CEP,
      'addressLine': addressLine,
      'number': number,
      'additionalInfo': additionalInfo,
      'lat': coordinates?.$1,
      'lng': coordinates?.$2,
    };
  }

  factory Address.fromDBMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      CEP: map['cep'],
      addressLine: map['addressLine'],
      number: map['number'],
      additionalInfo: map['additionalInfo'],
      coordinates: map['lat'] != null && map['lng'] != null
          ? (map['lat'], map['lng'])
          : null,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    final city = '${json['city']} - ${json['state']}';
    final street = json['street'] != null
        ? '${json['street']} - ${json['neighborhood']}'
        : null;

    final lat =
        double.tryParse(json['location']['coordinates']['latitude'] ?? '');
    final lng =
        double.tryParse(json['location']['coordinates']['longitude'] ?? '');

    return Address(
      CEP: json['cep'],
      addressLine: street != null ? '$street, $city' : city,
      coordinates: lat != null && lng != null ? (lat, lng) : null,
    );
  }
}
