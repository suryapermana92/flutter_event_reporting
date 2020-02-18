
import 'package:flutter/material.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/widgets/forms/steps/address_info_step.dart';
import 'package:ui_hlb_ekyc_mobile/features/apply_product/presentation/widgets/forms/steps/personal_info_step.dart';
import 'package:ui_hlb_ekyc_mobile/router.gr.dart';

class ApplyProductFormPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _ApplyProductFormState();
}

class _ApplyProductFormState extends State<ApplyProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  // State Initialize
  int currenStepIndex = 0;
  bool complete = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToPreviousStep() {
    if (currenStepIndex - 1 >= 0) {
      setState(() => currenStepIndex = currenStepIndex - 1);
    } else {
      Router.navigator.pop();
    }
  }

  void goToNextStep() {
    if(_formKey.currentState.validate()) {
      if (currenStepIndex + 1 < steps.length) {
        setState(() => currenStepIndex = currenStepIndex + 1);
      } else {
        // Step complete 
        setState(() => complete = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stepper(
                steps: steps,
                currentStep: currenStepIndex,
                onStepContinue: goToNextStep,
                onStepCancel: goToPreviousStep,
              ),
            ),
          ]
        ),
      )
    );
  }

  List<Step> steps = [
    Step(
      title: Text(PersonalInfoStep.title),
      state: StepState.editing,
      isActive: true,
      content: PersonalInfoStep(),
    ),
    Step(
      title: const Text(AddressInfoStep.title),
      isActive: true,
      state: StepState.disabled,
      content: AddressInfoStep(),
    ),
    Step(
      title: const Text('FATCA'),
      isActive: true,
      state: StepState.disabled,
      content: Column(
        children: <Widget>[
          Text('FATCA Form goes here')
        ],
      )
    )
  ];
}