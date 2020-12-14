import 'package:personal_diary/presentation/common/subscription_utils.dart';
import 'package:personal_diary/presentation/post_list/post_list_models.dart';
import 'package:rxdart/rxdart.dart';

class PostListBloc with SubscriptionBag {
  PostListBloc() {}

  // State
  final _onNewStateSubject = BehaviorSubject<PostListState>();

  Stream<PostListState> get onNewState => _onNewStateSubject.stream;

  // Actions
  final _onNewActionSubject = PublishSubject<PostListState>();

  Stream<PostListState> get onNewAction => _onNewActionSubject.stream;

  // Functions
  Stream<PostListState> _getPostList() async* {
    yield Loading();

    try {} catch (error) {}
  }

  void dispose() {
    _onNewActionSubject.close();
    _onNewStateSubject.close();
    super.disposeAll();
  }
}
