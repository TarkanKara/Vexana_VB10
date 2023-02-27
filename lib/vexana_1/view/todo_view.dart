// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vexana_vb10/vexana_1/service/todo_service.dart';
import 'package:vexana_vb10/vexana_1/viewmodel/cubit/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vexana"),
      ),
      body: BlocProvider(
          create: (context) => TodoCubit(TodoService()),
          child: BlocConsumer<TodoCubit, TodoState>(
              listener: (context, state) {},
              builder: (context, state) => Column())),
    );
  }
}
