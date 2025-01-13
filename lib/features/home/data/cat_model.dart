// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CatModel extends Equatable {
  final String id;
  final String url;
  final int width;
  final int height;
  const CatModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  CatModel copyWith({
    String? id,
    String? url,
    int? width,
    int? height,
  }) {
    return CatModel(
      id: id ?? this.id,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'width': width,
      'height': height,
    };
  }

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      id: map['id'] as String,
      url: map['url'] as String,
      width: map['width'] as int,
      height: map['height'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatModel.fromJson(String source) => CatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, url, width, height];
}
