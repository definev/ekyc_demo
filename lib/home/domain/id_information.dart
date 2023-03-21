class IDInformation {
  final String id;
  final String name;
  final String birth;
  final String home;
  final String add;

  IDInformation({
    required this.id,
    required this.name,
    required this.birth,
    required this.home,
    required this.add,
  });

  factory IDInformation.fromJson(Map<String, dynamic> json) {
    return IDInformation(
      id: json['id'],
      name: json['name'],
      birth: json['birth'],
      home: json['home'],
      add: json['add'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birth': birth,
      'home': home,
      'add': add,
    };
  }

  IDInformation copyWith({
    String? id,
    String? name,
    String? birth,
    String? home,
    String? add,
  }) {
    return IDInformation(
      id: id ?? this.id,
      name: name ?? this.name,
      birth: birth ?? this.birth,
      home: home ?? this.home,
      add: add ?? this.add,
    );
  }

  @override
  bool operator ==(Object? other) =>
      other is IDInformation && other.id == id && other.name == name && other.birth == birth && other.home == home && other.add == add;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ birth.hashCode ^ home.hashCode ^ add.hashCode;
}
