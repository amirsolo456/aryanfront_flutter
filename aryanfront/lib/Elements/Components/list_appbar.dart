import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../Headers/list_head_actionbar.dart';
import 'list_pagination.dart';
final Widget futuresIcon = Image.asset(
  'assets/images/futures.png',
  width: 24,
  height: 24,
);
final Widget moreIcon = Image.asset(
  'assets/images/more.png',
  width: 24,
  height: 24,
);

AppBar buildPersonListAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      textAlign: TextAlign.start,
      AppLocalizations.of(context)!.personList,
      style: TextStyle(color: Colors.black,),
    ),
    centerTitle: true,
    actions: [
      IconButton(onPressed: () {}, icon: futuresIcon,   highlightColor: Colors.black.withOpacity(0.05),),
      IconButton(onPressed: () {}, icon: moreIcon,   highlightColor: Colors.black.withOpacity(0.05),),
    ],
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    toolbarHeight: 70,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ListPagination(),
            ButtonPanel(),
          ],
        ),
      ),
    ),
  );
}
