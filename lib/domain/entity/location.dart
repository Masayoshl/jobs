class Location {
  final String? city;
  final String? address;
  final String? postalCode;

  Location({
    this.city,
    this.address,
    this.postalCode,
  });

  Location copyWith({
    String? city,
    String? address,
    String? postalCode,
  }) {
    return Location(
      city: city ?? this.city,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  String toString() =>
      'Location(city: $city, address: $address, postalCode: $postalCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location &&
        other.city == city &&
        other.address == address &&
        other.postalCode == postalCode;
  }

  @override
  int get hashCode => city.hashCode ^ address.hashCode ^ postalCode.hashCode;
}
