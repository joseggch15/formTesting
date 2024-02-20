import 'package:flutter/material.dart';

class Technician {
  final int id;
  final String firstName;
  final String lastName;

  Technician(
      {required this.id, required this.firstName, required this.lastName});

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Workshop {
  final int id;
  final String workshop;
  final DateTime? modifyDate;
  final DateTime registerDate;

  Workshop(
      {required this.id,
      required this.workshop,
      this.modifyDate,
      required this.registerDate});

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'],
      workshop: json['workshop'],
      modifyDate: json['modifyDate'] != null
          ? DateTime.parse(json['modifyDate'])
          : null,
      registerDate: DateTime.parse(json['registerDate']),
    );
  }
}

class Question {
  final int id;
  final String question;

  Question({required this.id, required this.question});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
    );
  }
}

// class Question {
//   final int id;
//   final String questionText;

//   Question({required this.id, required this.questionText});

//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//       id: json['id'],
//       questionText: json['questionText'],
//     );
//   }
// }

class NewInspectionFormData {
  String? selectedWorkshop;
  String? selectedTechnician;
  String? selectedAnswer;
  String? selectedDeviation;
  String? selectedQuestion;

  bool isChecked1 = false;
  bool isChecked2 = false;
  TextEditingController descriptionController = TextEditingController();

  List<Technician> technicians =
      []; // se extrae informacion de los datos de la clase Technician
  List<Workshop> workshops =
      []; // se extrae informacion de los datos de la clase Workshop
  int? selectedTechnicianId;
  int? selectedWorkshopId; // ID del taller seleccionado
  List<Question> questions = [];
  int? selectedQuestionId; // ID of the selected question
}
