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

  // Método para cargar talleres
  Future<void> fetchWorkshops() async {
    final response = await http.get(
      Uri.parse('http://3.129.92.139:8080/api/workshop/all'),
      headers: {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJhdXRob3JpdHkiOiJTdXBlcnVzZXIiLCJzdWIiOiJ0ZXN0IiwiaWF0IjoxNzA4Mzg0NzEzLCJleHAiOjE3MDgzODYxNTN9.oN2_tSkD437_dle_ur4IJoLL9QeuAGnc0h47FMqiziqW4FAiW2U9zDuTlMg9takF'
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
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJhdXRob3JpdHkiOiJTdXBlcnVzZXIiLCJzdWIiOiJ0ZXN0IiwiaWF0IjoxNzA4Mzg0NzEzLCJleHAiOjE3MDgzODYxNTN9.oN2_tSkD437_dle_ur4IJoLL9QeuAGnc0h47FMqiziqW4FAiW2U9zDuTlMg9takF'
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

  // Método para enviar formulario
  // Future<void> submitForm() async {
  //   if (formKey.currentState!.validate()) {
  //     // Asegúrate de enviar 'selectedWorkshopId' en lugar de 'selectedWorkshop'
  //     var postBody = jsonEncode({
  //       "questionId": 3,
  //       "workshopId": 2, // Cambio aquí
  //       // "workshopId": data.selectedWorkshopId ?? 0, // Cambio aquí
  //       // "answerId": int.tryParse(data.selectedAnswer ?? '0') ?? 0,
  //       "answerId": 1,
  //       "remedialId": 2,
  //       // "deviationId": int.tryParse(data.selectedDeviation ?? '0') ?? 0,
  //       "deviationId": 3,
  //       //  "userId": data.selectedTechnicianId ?? 0
  //       "userId": 3
  //     });

  //     final response = await http.post(
  //       Uri.parse(
  //           'http://3.129.92.139:8080/api/check/save'), // Asegúrate de reemplazar con la base URL correcta
  //       headers: {
  //         'Authorization':
  //             ' Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJhdXRob3JpdHkiOiJTdXBlcnVzZXIiLCJzdWIiOiJ0ZXN0IiwiaWF0IjoxNzA4MzgzMDg1LCJleHAiOjE3MDgzODQ1MjV9.HhjqHT-K7OpUdoBUelhCXGkb0uYY587eM2I6NSXQRhH3jEHUO-UJsLcrsVRoesKv'
  //       },
  //       body: postBody,
  //     );

  //     if (response.statusCode == 200) {
  //      print("se envio con exito la peticion del SUBMIT"); // Éxito
  //     } else {
  //       print("Fallo la enviada del SUBMIT"); // Manejo de errores
  //     }
  //   }
  // }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      var postBody = jsonEncode({
        "questionId": 3,
        "workshopId": data.selectedWorkshop,
        "answerId": 1,
        "remedialId": 2,
        "deviationId": 3,
        "userId": data.selectedTechnicianId,
      });

      try {
        final response = await http.post(
          Uri.parse('http://3.129.92.139:8080/api/check/save'),
          headers: {
            'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJhdXRob3JpdHkiOiJTdXBlcnVzZXIiLCJzdWIiOiJ0ZXN0IiwiaWF0IjoxNzA4Mzg0NzEzLCJleHAiOjE3MDgzODYxNTN9.oN2_tSkD437_dle_ur4IJoLL9QeuAGnc0h47FMqiziqW4FAiW2U9zDuTlMg9takF',
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
