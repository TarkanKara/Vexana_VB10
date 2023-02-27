// ignore_for_file: unused_element

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vexana_vb10/vexana_1/model/todo_model.dart';

import '../../service/todo_service.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  List<TodoModel>? todoModel;
  final TodoService service;

  bool isLoading = false;

  TodoCubit(this.service) : super(TodoInitial()) {
    _init();
  }

  Future<void> _init() async {
    changeLoading();
    await fetchCommentsData();
    changeLoading();
  }

  changeLoading() {
    isLoading = !isLoading;
    emit(TodoLoading());
  }

  Future<List<TodoModel>?> fetchCommentsData() async {
    try {
      todoModel = await service.getTodoList();
      print(todoModel?[0].email);
      return todoModel;
    } catch (e) {
      throw Exception("Exception : $e");
    }
  }
}
