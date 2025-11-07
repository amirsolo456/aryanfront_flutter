import 'package:flutter/material.dart';

typedef FirstLoadBuilder = Widget Function(BuildContext context, bool isFirstLoad);

class FirstLoadWrapper extends StatefulWidget {
  final FirstLoadBuilder builder;
  final VoidCallback? onFirstLoadDone;

  const FirstLoadWrapper({
    super.key,
    required this.builder,
    this.onFirstLoadDone,
  });

  @override
  State<FirstLoadWrapper> createState() => _FirstLoadWrapperState();
}

class _FirstLoadWrapperState extends State<FirstLoadWrapper> {
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isFirstLoad) {
        widget.onFirstLoadDone?.call();
        setState(() {
          _isFirstLoad = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _isFirstLoad);
  }
}
