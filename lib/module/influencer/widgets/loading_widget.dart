import 'package:flutter/material.dart';

class LoadWidgetBuilder extends StatefulWidget {
  final bool hasData;

  final WidgetBuilder onNoData;
  final WidgetBuilder onLoading;
  final WidgetBuilder onDataLoaded;
  final WidgetState? widgetState;

  const LoadWidgetBuilder(
      {Key? key,
      required this.hasData,
      required this.onNoData,
      required this.onLoading,
      required this.onDataLoaded,
      required this.widgetState})
      : super(key: key);

  @override
  State<LoadWidgetBuilder> createState() => _LoadWidgetBuilderState();
}

class _LoadWidgetBuilderState extends State<LoadWidgetBuilder> {
  @override
  Widget build(BuildContext context) {
    if (!widget.hasData && widget.widgetState != null && widget.widgetState == WidgetState.LOADING) {
      return widget.onLoading(context);
    }
    if (!widget.hasData) {
      return widget.onNoData(context);
    }
    return widget.onDataLoaded(context);
  }
}

enum WidgetState {
  LOADING,
  LOADED,
}
