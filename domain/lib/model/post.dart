import 'package:meta/meta.dart';

class Post {
  const Post({
    @required this.title,
    @required this.content,
    @required this.feeling,
    @required this.dateStringList,
  })  : assert(title != null),
        assert(content != null),
        assert(feeling != null),
        assert(dateStringList != null);
  final String title;
  final String content;
  final String feeling;
  final List<String> dateStringList;
}
