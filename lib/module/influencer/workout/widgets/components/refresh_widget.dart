import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWidget extends StatelessWidget {
  final RefreshController refreshController;
  final Function() onRefresh;
  final Function() onLoadMore;
  final bool enablePullDown;
  final bool enablePullUp;
  final Widget child;

  const RefreshWidget(
      {Key? key,
      required this.refreshController,
      required this.onRefresh,
      required this.onLoadMore,
      required this.child,
      this.enablePullDown = true,
      this.enablePullUp = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        header: const WaterDropHeader(),
        footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          // if (mode == LoadStatus.idle) {
          //   body = Text("pull up load");
          // } else
          if (mode == LoadStatus.loading) {
            body = const CircularProgressIndicator(strokeWidth: 2);
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("release to load more");
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        }),
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoadMore,
        child: child);
  }
}
