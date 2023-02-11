import 'package:apps.daily_memo/domain/model/home/memo_list_item.dart';
import 'package:apps.daily_memo/domain/model/memo/add_memo_model.dart';
import 'package:apps.daily_memo/domain/model/memo/modify_memo_model.dart';
import 'package:apps.daily_memo/domain/repository_interface/memo_repository.dart';
import 'package:apps.daily_memo/domain/usecase/memo_usecase.dart';
import 'package:apps.daily_memo/presentation/core/route/app_routes.dart';
import 'package:apps.daily_memo/presentation/core/route/routes_controller.dart';
import 'package:apps.daily_memo/presentation/core/route/routes_controller_impl/routes_controller_modular_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MemoViewModel {
  late final MemoUsecase _memoUsecase;
  final BehaviorSubject<MemoListItem?> existedMemo =
      BehaviorSubject.seeded(null);
  final RoutesController routesController = RoutesControllerModularImpl();

  MemoViewModel({
    int? memoId,
    required MemoRepository memoRepository,
  }) {
    _memoUsecase = MemoUsecase(memoRepository);
    if (memoId != null) {
      _memoUsecase.getMemoById(memoId).asStream().listen((event) {
        existedMemo.add(event);
      });
    }
  }

  // TODO: _existedMemo가 스트림인데

  // TODO: callback
  // TODO: SharedPreference
  Future<void> addMemo(
      String title, String content, BuildContext context) async {
    try {
      await _memoUsecase.addMemo(AddMemoModel(title, content));
      routesController.toPushNamed(context, AppRoutes.HOME.path);
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => Container(
                child: Text("실패"),
              ));
    }
  }

  Future<void> modifyMemo(
    int memoId,
    String title,
    String content,
    BuildContext context,
  ) async {
    await _memoUsecase.modifyMemo(ModifyMemoModel(memoId, title, content));
    routesController.toPushNamed(context, AppRoutes.HOME.path);
  }

}