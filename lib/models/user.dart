import 'dart:convert';

class User {
  final int? id; // int? can be NULL (to correct later!!) -JP(25.09.2021)
  final String name;
  final String office;
  final int weeklyhours;
  final int persnr;
  final int aktiv;

  User({
    this.id,
    required this.name,
    required this.office,
    required this.weeklyhours,
    required this.persnr,
    required this.aktiv,
  });

  User copyWith({
    int? id,
    String? name,
    String? office,
    int? weeklyhours,
    int? persnr,
    int? aktiv,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      office: office ?? this.office,
      weeklyhours: weeklyhours ?? this.weeklyhours,
      persnr: persnr ?? this.persnr,
      aktiv: aktiv ?? this.aktiv,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'office': office,
        'weeklyhours': weeklyhours,
        'persnr': persnr,
        'aktiv': aktiv,
      };

  factory User.fromMap(Map<String, dynamic> map) => new User(
        id: map['id'],
        name: map['name'],
        office: map['office'],
        weeklyhours: map['weeklyhours'],
        persnr: map['persnr'],
        aktiv: map['aktiv'],
      );

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(id: $id, name: $name, office: $office, weeklyhours: $weeklyhours, persnr: $persnr, aktiv: $aktiv)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.office == office &&
        other.weeklyhours == weeklyhours &&
        other.persnr == persnr &&
        other.aktiv == aktiv;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      office.hashCode ^
      weeklyhours.hashCode ^
      persnr.hashCode ^
      aktiv.hashCode;
}
