import 'package:aryanfront/Elements/Expanders/list_datas_expander.dart'
    show PersonExpander;
import 'package:aryanfront/Pages/List/ListBlocs/Com/PersonBloc/person_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder;

class PersonListPage extends StatefulWidget {
  const PersonListPage({super.key});

  @override
  State<PersonListPage> createState() => _PersonListPage();
}

class _PersonListPage extends State<PersonListPage> {
  @override
  void initState() {
    BlocProvider.of<PersonListBloc>(context).add(LoadDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aryan Front')),
      body: BlocBuilder<PersonListBloc, PersonlistState>(
        builder: (context, state) {
          if (state is LoadDataLoading) {
            return Center(
              child: CupertinoActivityIndicator(
                color: Colors.black,
                radius: 20,
              ),
            );
          } else if (state is LoadDataSuccess) {
            return Center(child: Text('Success'));
          } else if (state is LoadDataError) {
            return Text('Error');
          } else if (state is LoadDataSendListDatas) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return PersonExpander(person: state.data[index]);
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
