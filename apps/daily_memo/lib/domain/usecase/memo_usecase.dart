import 'package:apps.daily_memo/domain/model/home/memo_list_item.dart';
import 'package:apps.daily_memo/domain/repository_interface/memo_repository.dart';

class MemoUsecase {
  final MemoRepository memoRepository;

  MemoUsecase(this.memoRepository);

  Future<List<MemoListItem>> get getMemoList => memoRepository.getMemoList;
}