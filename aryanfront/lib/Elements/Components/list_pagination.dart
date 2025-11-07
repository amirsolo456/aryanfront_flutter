import 'package:flutter/material.dart';
import '../Buttons/dynamic_button.dart';

class ListPagination extends StatefulWidget {
  const ListPagination({super.key});

  @override
  State<ListPagination> createState() => _ListPaginationState();
}

class _ListPaginationState extends State<ListPagination> {
  final Widget leftArrow = Image.asset(
    'assets/images/pagination_left.png',
    width: 24,
    height: 24,
  );
  final Widget rightArrow = Image.asset(
    'assets/images/pagination_right.png',
    width: 24,
    height: 24,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          IconButton(
            onPressed: onPressedd,
            icon:rightArrow,
            highlightColor: Colors.orange.withOpacity(0),
          ),
          // DynamicButton(
          //   onPressed: onPressedd,
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   borderRadius: 0,
          //   size: 36,
          //   icon: rightArrow,
          //   useDefaultAnimation: false,
          // ),
          SizedBox(width: 20),
          Text('2'),
          SizedBox(width: 20),
          IconButton(
            onPressed: onPressedd,
            icon:leftArrow,
            highlightColor: Colors.orange.withOpacity(0),
          ),
          // DynamicButton(
          //   onPressed: onPressedd,
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   borderRadius: 0,
          //   size: 36,
          //   icon: leftArrow,
          //   useDefaultAnimation: false,
          // ),
        ],
      ),
    );
  }

  void onPressedd() {}
}
