import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_parse/search/bloc/search_bloc.dart';
import 'package:hh_parse/search/bloc/search_event.dart';
import 'package:hh_parse/search/bloc/search_state.dart';
import 'package:hh_parse/widgets/search_tf.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StartScreen extends StatelessWidget {

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  final _formKey = GlobalKey<FormState>();
  StartScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case InitialState: return CircularProgressIndicator();
            case UpdateScreen:
              var vacancies = (state as UpdateScreen).vacancies;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFieldWidget(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {},
                    validator: (value) {},
                    controller: _searchController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SearchBloc>().add(SearchButtonPressed(_searchController.text));
                    },
                    child: Text('Search'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SearchBloc>().add(SaveButtonPressed());
                    },
                    child: Text('Parse'),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    color: const Color.fromRGBO(34, 34, 34, 100),
                    child: SingleChildScrollView(
                      child: Text('${vacancies.length}'),
                      //child: Row(
                        // children: [
                        //   Column(
                        //         children: List.generate(vacancies.length, (index) {
                        //           final vacancy = vacancies[index];
                        //           return Text(vacancy.name);
                        //         }),
                        //   ),
                        //   Column(
                        //     children: List.generate(vacancies.length, (index) {
                        //       final vacancy = vacancies[index];
                        //       return Text(vacancy.users);
                        //     }),
                        //   )
                        // ],
                      //)
                    ),
                  ),
                ],
              );
          }
          return Placeholder();
        },
      ),
    );
  }




}