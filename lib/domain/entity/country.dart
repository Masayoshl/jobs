class Country {
  final String? capital;
  final String code;
  final String? continent;
  final String flag1x1;
  final String flag4x3;
  final bool iso;
  final String name;

  const Country({
    this.capital,
    required this.code,
    this.continent,
    required this.flag1x1,
    required this.flag4x3,
    required this.iso,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        capital: json['capital'],
        code: json['code'],
        continent: json['continent'],
        flag1x1: json['flag_1x1'],
        flag4x3: json['flag_4x3'],
        iso: json['iso'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'capital': capital,
        'code': code,
        'continent': continent,
        'flag_1x1': flag1x1,
        'flag_4x3': flag4x3,
        'iso': iso,
        'name': name,
      };
}
