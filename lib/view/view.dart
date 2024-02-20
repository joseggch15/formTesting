import 'package:flutter/material.dart';
import '../controllers/controller.dart';
import '../model/model.dart';

class NewInspectionFormView extends StatefulWidget {
  final NewInspectionFormController controller;
  final NewInspectionFormData data;

  NewInspectionFormView({required this.controller, required this.data});

  @override
  _NewInspectionFormViewState createState() => _NewInspectionFormViewState();
}

class _NewInspectionFormViewState extends State<NewInspectionFormView> {
  @override
  void initState() {
    super.initState();
    widget.controller.fetchTechnicians();
    widget.controller.fetchWorkshops();
    widget.controller.fetchQuestions();
    widget.controller.fetchAnswers();
    widget.controller.fetchDeviations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Inspection'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButtonFormField<int>(
                value: widget.data.selectedWorkshopId,
                onChanged: (newValue) {
                  setState(() {
                    widget.data.selectedWorkshopId = newValue;
                  });
                },
                items: widget.data.workshops.map((workshop) {
                  return DropdownMenuItem<int>(
                    value: workshop.id,
                    child: Text('${workshop.workshop}'),
                    // child: Text('${technician.firstName} ${technician.lastName}'),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'workshop'),
              ),

              SizedBox(height: 13.0),

              // Dropdown para técnicos
              DropdownButtonFormField<int>(
                value: widget.data.selectedTechnicianId,
                onChanged: (newValue) {
                  setState(() {
                    widget.data.selectedTechnicianId = newValue;
                  });
                },
                items: widget.data.technicians.map((technician) {
                  return DropdownMenuItem<int>(
                    value: technician.id,
                    child:
                        Text('${technician.firstName} ${technician.lastName}'),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Technician'),
              ),

              // Dropdown para questions
              // DropdownButtonFormField<int>(
              //   value: widget.data.selectedQuestionId,
              //   onChanged: (newValue) {
              //     setState(() {
              //       widget.data.selectedQuestionId = newValue;
              //     });
              //   },
              //   items: widget.data.questions.map((question) {
              //     return DropdownMenuItem<int>(
              //       value: question.id,
              //       child: Container(
              //         width:
              //             double.infinity, // Ajustar el ancho al máximo posible
              //         child: Text(
              //           '${question.question}',
              //           softWrap: true,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(labelText: 'Questions'),
              // ),

              // DropdownButtonFormField<int>(
              //   value: widget.data.selectedQuestionId,
              //   onChanged: (newValue) {
              //     setState(() {
              //       widget.data.selectedQuestionId = newValue;
              //     });
              //   },
              //   items: widget.data.questions
              //       .map<DropdownMenuItem<int>>((Question question) {
              //     return DropdownMenuItem<int>(
              //       value: question.id,
              //       child: Text(question.question),
              //     );
              //   }).toList(),
              // ),

              //  Dropdown para questions
              DropdownButtonFormField<int>(
                value: widget.data.selectedQuestionId,
                onChanged: (newValue) {
                  setState(() {
                    widget.data.selectedQuestionId = newValue;
                  });
                },
                items: widget.data.questions.map((question) {
                  return DropdownMenuItem<int>(
                    value: question.id,
                    child: Text('${question.question}'),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Questions'),
              ),

              //  Dropdown para answer
              DropdownButtonFormField<int>(
                value: widget.data.selectedAnswerId,
                onChanged: (newValue) {
                  setState(() {
                    widget.data.selectedAnswerId = newValue;
                  });
                },
                items: widget.data.answers.map((answer) {
                  return DropdownMenuItem<int>(
                    value: answer.id,
                    child: Text(answer
                        .answer), // Suponiendo que 'answerText' es la propiedad que contiene el texto de la respuesta
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Answer'),
              ),

              DropdownButtonFormField<int>(
                value: widget.data.selectedDeviationId,
                onChanged: (newValue) {
                  setState(() {
                    widget.data.selectedDeviationId = newValue;
                  });
                },
                items: widget.data.deviations.map((deviation) {
                  return DropdownMenuItem<int>(
                    value: deviation.id,
                    child: Text(deviation
                        .deviationText), // Asegúrate de que 'deviationText' es la propiedad que contiene el texto de la desviación
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Deviation'),
              ),

// Nuevo TextFormField para la descripción corta
              // TextFormField(
              //   initialValue: widget.data.shortDescription,
              //   onChanged: (newValue) {
              //     setState(() {
              //       widget.data.shortDescription = newValue;
              //     });
              //   },
              //   maxLines: null,
              //   keyboardType: TextInputType.multiline,
              //   decoration: InputDecoration(
              //     labelText: 'Short Description of what is going on',
              //     alignLabelWithHint: true,
              //     border: OutlineInputBorder(),
              //   ),
              // ),

              // SizedBox(height: 13.0),

              // DropdownButtonFormField<int>(
              //   value: widget.data.selectedQuestionId,
              //   onChanged: (newValue) {
              //     setState(() {
              //       widget.data.selectedQuestionId = newValue;
              //     });
              //   },
              //   items: widget.data.questions.map((question) {
              //     return DropdownMenuItem<int>(
              //       value: question.id,
              //       child: Text(question.questionText),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(labelText: 'Question'),
              // ),

              // ...otros widgets como 'Answer', etc.

              // Botón de envío
              ElevatedButton(
                onPressed: widget.controller.submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
