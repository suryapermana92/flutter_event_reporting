

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/new_form_bloc/bloc.dart';
import '../../../domain/repositories/apply_product_repository.dart';
import '../../widgets/forms/personal_information_form.dart';

class PersonalInformationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Information'),
      ),
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: BlocProvider<NewFormBloc>(
              create: (context) => NewFormBloc(applyProductRepository: ApplyProductRepository()),
              child: PersonalInformationForm(),
            ),
          ),
        ),
      ),
    );
  }
}