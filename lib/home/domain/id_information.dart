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
}
