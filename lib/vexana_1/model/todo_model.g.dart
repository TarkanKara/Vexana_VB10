// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      postId: json['postId'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'postId': instance.postId,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
