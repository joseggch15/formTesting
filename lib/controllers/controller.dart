import 'package:flutter/material.dart';
import '../model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String authToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJhdXRob3JpdHkiOiJTdXBlcnVzZXIiLCJzdWIiOiJ0ZXN0IiwiaWF0IjoxNzA4NDY0ODM3LCJleHAiOjE3MDg0NjYyNzd9.ruz5UOu3Hcc2ey2u0qBr4w6G90V_lyj06inDmaZIYk2UwLKY_Ju1RgdR8CzN6THH';

class NewInspectionFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NewInspectionFormData data;

  NewInspectionFormController({required this.data});

  // Métodos existentes...
  void onWorkshopChanged(String? newValue) {
    data.selectedWorkshop = newValue;
  }

  void onAnswerChanged(String? newValue) {
    data.selectedAnswer = newValue;
  }

  void onDeviationChanged(String? newValue) {
    data.selectedDeviation = newValue;
  }

  // Método para cargar talleres
  Future<void> fetchWorkshops() async {
    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/workshop/all'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> workshopsJson = json.decode(response.body);
      data.workshops =
          workshopsJson.map((json) => Workshop.fromJson(json)).toList();
    } else {
      // Manejo de errores workshop
    }
  }

  // Métodos existentes para cargar técnicos y otros...

  // Método para cargar técnicos
  Future<void> fetchTechnicians() async {
    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/user/technicians'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> techniciansJson = json.decode(response.body);
      data.technicians =
          techniciansJson.map((json) => Technician.fromJson(json)).toList();
    } else {
      // Manejo de errores en technician
    }
  }

  // Método para cargar questions
  Future<void> fetchQuestions() async {
    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/question/all'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> questionsJson = json.decode(response.body);
      data.questions =
          questionsJson.map((json) => Question.fromJson(json)).toList();
    } else {
      // Manejo de errores en technician
    }
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      var postBody = jsonEncode({
        "questionId":
            3, // Asegúrate de que este valor sea correcto o dinámico si es necesario
        "workshopId": data.selectedWorkshopId ?? 0,
        "answerId":
            1, // Asegúrate de que este valor sea correcto o dinámico si es necesario
        "remedialId":
            2, // Asegúrate de que este valor sea correcto o dinámico si es necesario
        "deviationId":
            3, // Asegúrate de que este valor sea correcto o dinámico si es necesario
        "userId": data.selectedTechnicianId ?? 0
      });

      try {
        final response = await http.post(
          Uri.parse('http://3.129.92.139:8080/api/check/save'),
          headers: {
            'Authorization':
                'Bearer $authToken', // Reemplaza YOUR_TOKEN_HERE con tu token
            'Content-Type': 'application/json',
          },
          body: postBody,
        );

        if (response.statusCode == 200) {
          print("Envío exitoso: ${response.body}");
        } else {
          print("Fallo en el envío: ${response.statusCode} - ${response.body}");
        }
      } catch (e) {
        print("Error en la conexión: $e");
      }
    }
  }
}
