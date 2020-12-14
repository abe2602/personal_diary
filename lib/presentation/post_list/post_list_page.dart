import 'package:domain/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_diary/presentation/common/adaptative_scaffold.dart';
import 'package:personal_diary/presentation/common/async_snapshot_response_view.dart';
import 'package:personal_diary/presentation/common/personal_diary_colors.dart';
import 'package:personal_diary/presentation/post_list/post_list_bloc.dart';
import 'package:personal_diary/presentation/post_list/post_list_models.dart';

// final dateStringList = DateFormat.yMMMd()
//     .format(DateTime.now())
//     .replaceAll(',', '')
//     .replaceAll('de', '')
//     .split(' ')
//   ..sort()
//   ..removeWhere((e) => e == '' || e == ',');

// _PostCard(
// title: 'Such a sad day',
// content: 'No mundo atual, a valorização de fatores subjetivos '
// 'desafia a capacidade de equalização do retorno '
// 'esperado a longo prazo.',
// date: dateStringList,
// emoticon: '🌈',
// );

class PostListPage extends StatelessWidget {
  const PostListPage({
    @required this.bloc,
  }) : assert(bloc != null);

  final PostListBloc bloc;

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
        title: 'Hey',
        body: StreamBuilder(
          stream: bloc.onNewState,
          builder: (context, snapshot) =>
              AsyncSnapshotResponseView<Loading, Error, Success>(
            snapshot: snapshot,
            successWidgetBuilder: (success) => ListView.builder(
              itemCount: success.postList.length,
              itemBuilder: (_, index) => _PostCard(
                post: success.postList[index],
              ),
            ),
            errorWidgetBuilder: (error) {
              return Text('Erro');
            },
          ),
        ),
      );
}

class _DateIndicator extends StatelessWidget {
  const _DateIndicator({
    @required this.dateStringList,
  }) : assert(dateStringList != null);

  final List<String> dateStringList;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              dateStringList[2],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              dateStringList[1],
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              dateStringList[0],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    @required this.post,
  }) : assert(post != null);

  final Post post;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      post.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(post.feeling),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: PersonalDiaryColors.divisorColor,
                  height: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _DateIndicator(
                    dateStringList: post.dateStringList,
                  ),
                  Expanded(
                    child: Text(
                      post.content,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
