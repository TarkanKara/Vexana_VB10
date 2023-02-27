// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vexana/vexana.dart';
import 'package:vexana_vb10/vexana_1/core/const.dart';
import 'package:vexana_vb10/vexana_1/model/todo_model.dart';

import '../core/extension/network_path.dart';

class TodoService {
  //final BuildContext context;
  late INetworkManager networkManager;

  TodoService() {
    networkManager = NetworkManager<Null>(
      options: BaseOptions(
        baseUrl: BaseUrll.baseUrll,
      ),
      isEnableLogger: true,
      //onRefreshFail: () {},
      //onRefreshToken: (error, newService) {},
    );
  }

  //
  Future<List<TodoModel>?> getTodoList() async {
    final response = await networkManager.send<TodoModel, List<TodoModel>?>(
        NetworkPath.COMMENTS.rawValue,
        //urlSuffix: ,
        parseModel: TodoModel(),
        method: RequestType.GET);
    if (response.data != null) {
      //snackbar
      //showAboutDialog(context: context);
    }
    return response.data;
  }
}
