import 'package:equatable/equatable.dart';

class Medicament extends Equatable {
  final int? id;
  final String name;
  final String? imagePath;
  final String date;
  final bool isExpired;

  const Medicament({
    this.id,
    required this.name,
    this.imagePath,
    required this.date,
    required this.isExpired,
  });

  @override
  List<Object> get props => [id!, name, date, isExpired];

  Medicament copyWith({
    String? name,
    String? imagePath,
    String? date,
    bool? isExpired,
  }) {
    return Medicament(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      isExpired: isExpired ?? this.isExpired,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'imagePath': imagePath,
      'date': date,
      'isExpired': isExpired ? 1 : 0,
    };
  }

  factory Medicament.fromJson(Map<String, dynamic> map) {
    return Medicament(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'],
      date: map['date'],
      isExpired: map['isExpired'] == 1 ? true : false,
    );
  }
}
