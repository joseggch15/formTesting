import 'package:flutter/material.dart';

class Technician {
  final int id;
  final String firstName;
  final String lastName;

  Technician({required this.id, required this.firstName, required this.lastName});

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}


class NewInspectionFormData {
  String? selectedWorkshop;
  String? selectedTechnician;
  String? selectedAnswer;
  String? selectedDeviation;
  bool isChecked1 = false;
  bool isChecked2 = false;
  TextEditingController descriptionController = TextEditingController();


  List<Technician> technicians = []; // se extrae informacion de los datos de la clase technician
  int? selectedTechnicianId;
}
