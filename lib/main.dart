import 'package:flutter/material.dart';
import './controllers/controller.dart';
import './model/model.dart';
import './view/view.dart';

void main() {
  NewInspectionFormData formData = NewInspectionFormData();
  NewInspectionFormController formController = NewInspectionFormController(data: formData);
  
  runApp(MyApp(formController: formController, formData: formData));
}

class MyApp extends StatelessWidget {
  final NewInspectionFormController formController;
  final NewInspectionFormData formData;

  MyApp({required this.formController, required this.formData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Inspection Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NewInspectionFormView(controller: formController, data: formData),
    );
  }
}
