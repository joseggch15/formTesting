import 'package:flutter/material.dart';
import '../model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  // ...otros métodos existentes

  // Método para cargar técnicos
  Future<void> fetchTechnicians() async {
    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/user/technicians'),
      headers: {'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJhdXRob3JpdHkiOiJTdXBlcnVzZXIiLCJzdWIiOiJ0ZXN0IiwiaWF0IjoxNzA4Mzc0OTE2LCJleHAiOjE3MDgzNzYzNTZ9.xA6vaxKntjT7vmCSKJ97Kf103giFulwUDccsPl1VV0WjE2JYgBCSA5rYNhikWpW6'},
    );

    if (response.statusCode == 200) {
      List<dynamic> techniciansJson = json.decode(response.body);
      data.technicians = techniciansJson.map((json) => Technician.fromJson(json)).toList();
    } else {
      // Manejo de errores
    }
  }

  // Método para enviar formulario
// Método para enviar formulario
Future<void> submitForm() async {
  if (formKey.currentState!.validate()) {
    // Construyendo el JSON para la solicitud POST
    var postBody = jsonEncode({
      "questionId": 3,  // Asumiendo que estos valores son estáticos según su ejemplo
      "workshopId": int.tryParse(data.selectedWorkshop ?? '0') ?? 0,
      "answerId": int.tryParse(data.selectedAnswer ?? '0') ?? 0,
      "remedialId": 2,  // Asumiendo valor estático
      "deviationId": int.tryParse(data.selectedDeviation ?? '0') ?? 0,
      "userId": data.selectedTechnicianId ?? 0
    });

    final response = await http.post(
      Uri.parse('http://{{base_url}}:8080/api/check/save'),
      headers: {'Authorization': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJhdXRob3JpdHkiOiJTdXBlcnVzZXIiLCJzdWIiOiJ0ZXN0IiwiaWF0IjoxNzA4Mzc0OTE2LCJleHAiOjE3MDgzNzYzNTZ9.xA6vaxKntjT7vmCSKJ97Kf103giFulwUDccsPl1VV0WjE2JYgBCSA5rYNhikWpW6'},  // Reemplace 'tu_token' con el token real
      body: postBody,
    );

    if (response.statusCode == 200) {
      // Éxito
    } else {
      // Manejo de errores
    }
  }
}







}
