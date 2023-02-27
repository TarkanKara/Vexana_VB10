import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends INetworkModel<TodoModel> {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  TodoModel({this.postId, this.id, this.name, this.email, this.body});

  @override
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  @override
  fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
}
