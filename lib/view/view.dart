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
                    child: Text('${technician.firstName} ${technician.lastName}'),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Technician'),
              ),
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
