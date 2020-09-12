import 'package:flutter/widgets.dart';
import 'package:personal_diary/presentation/common/subscription_utils.dart';

class PersonalDiaryActionListener<T> extends StatefulWidget {
  const PersonalDiaryActionListener({
    @required this.child,
    @required this.actionStream,
    @required this.onReceived,
    Key key,
  })  : assert(child != null),
        assert(actionStream != null),
        assert(onReceived != null),
        super(key: key);

  final Widget child;
  final Stream<T> actionStream;
  final Function(T action) onReceived;

  @override
  _PersonalDiaryActionListenerState<T> createState() =>
      _PersonalDiaryActionListenerState<T>();
}

class _PersonalDiaryActionListenerState<T>
    extends State<PersonalDiaryActionListener<T>> with SubscriptionBag {
  @override
  void initState() {
    widget.actionStream
        .listen(
          widget.onReceived,
        )
        .addTo(subscriptionsBag);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    disposeAll();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
