import 'package:flutter/material.dart';

class AddStagePage extends StatefulWidget {
  @override
  _AddStagePageState createState() => _AddStagePageState();
}

class _AddStagePageState extends State<AddStagePage> {
  final _formKey = GlobalKey<FormState>();

  String? title;
  String? description;
  String? subject;
  String? duration;
  DateTime? startDate;
  String? level;
  String? type; // Hybride, sur site, en ligne
  bool isPaid = false; // Rémunéré ou non
  final List<String> softSkills = [];
  final List<String> hardSkills = [];

  final List<String> levels = ['Licence', 'Ingénieur', 'Master', 'Doctorat'];
  final List<String> types = ['Hybride', 'Sur site', 'En ligne'];
  final List<String> softSkillsSuggestions = ['Communication', 'Travail en équipe', 'Résolution de problèmes'];
  final List<String> hardSkillsSuggestions = ['Programmation', 'Analyse de données', 'Gestion de projets'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Stage'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Titre
                _buildTextField(
                  label: 'Titre du Stage',
                  onSaved: (value) => title = value,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Veuillez entrer un titre' : null,
                ),

                SizedBox(height: 16),

                // Description
                _buildTextField(
                  label: 'Description',
                  maxLines: 5,
                  onSaved: (value) => description = value,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Veuillez entrer une description' : null,
                ),

                SizedBox(height: 16),

                // Sujet
                _buildTextField(
                  label: 'Sujet',
                  onSaved: (value) => subject = value,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Veuillez entrer un sujet' : null,
                ),

                SizedBox(height: 16),

                // Durée
                _buildTextField(
                  label: 'Durée (en mois)',
                  keyboardType: TextInputType.number,
                  onSaved: (value) => duration = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une durée';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Veuillez entrer un nombre valide';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                // Date de début
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        startDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      startDate == null
                          ? 'Sélectionner une date de début'
                          : 'Date de début: ${startDate!.toLocal()}'.split(' ')[0],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Niveau d'étude
                _buildDropdown(
                  label: 'Niveau d\'étude',
                  items: levels,
                  value: level,
                  onChanged: (value) => setState(() => level = value),
                ),

                SizedBox(height: 16),

                // Type (Hybride, sur site, en ligne)
                _buildDropdown(
                  label: 'Type de stage',
                  items: types,
                  value: type,
                  onChanged: (value) => setState(() => type = value),
                ),

                SizedBox(height: 16),

                // Rémunération
                Row(
                  children: [
                    Text('Rémunéré : ', style: TextStyle(fontSize: 16)),
                    Switch(
                      value: isPaid,
                      onChanged: (value) => setState(() => isPaid = value),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Soft Skills
                _buildChipsInput(
                  label: 'Soft Skills',
                  suggestions: softSkillsSuggestions,
                  selectedItems: softSkills,
                ),

                SizedBox(height: 16),

                // Hard Skills
                _buildChipsInput(
                  label: 'Hard Skills',
                  suggestions: hardSkillsSuggestions,
                  selectedItems: hardSkills,
                ),

                SizedBox(height: 32),

                // Bouton d'ajout
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      print('Titre: $title');
                      print('Description: $description');
                      print('Sujet: $subject');
                      print('Durée: $duration mois');
                      print('Date de début: $startDate');
                      print('Niveau d\'étude: $level');
                      print('Type: $type');
                      print('Rémunéré: $isPaid');
                      print('Soft Skills: $softSkills');
                      print('Hard Skills: $hardSkills');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Stage ajouté avec succès!')),
                      );
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text('Ajouter le Stage'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      onSaved: onSaved,
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      ))
          .toList(),
      value: value,
      onChanged: onChanged,
      validator: (value) => value == null ? 'Veuillez sélectionner $label' : null,
    );
  }

  Widget _buildChipsInput({
    required String label,
    required List<String> suggestions,
    required List<String> selectedItems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: suggestions.map((suggestion) {
            final isSelected = selectedItems.contains(suggestion);
            return FilterChip(
              label: Text(suggestion),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedItems.add(suggestion);
                  } else {
                    selectedItems.remove(suggestion);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
