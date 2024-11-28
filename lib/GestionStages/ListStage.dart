import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListStage extends StatefulWidget {
  const ListStage({super.key});

  @override
  State<ListStage> createState() => _ListStageState();
}

class _ListStageState extends State<ListStage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Liste des stages récupérée depuis Firestore (ou d'une autre source)
  List<Map<String, String>> stages = [];

  // Fonction pour récupérer les stages de Firestore
  Future<void> _getStages() async {
    final snapshot = await _firestore.collection('stages').get();
    final stageData = snapshot.docs.map((doc) {
      return {
        'title': doc['title'],
        'description': doc['description'],
        'startDate': doc['startDate'],
      };
    }).toList();

    setState(() {
      stages = List.empty();
    });
  }

  @override
  void initState() {
    super.initState();
    _getStages();  // Récupérer les stages au démarrage
  }

  // Fonction pour se déconnecter
  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Stages'),
      ),
      drawer: AppDrawer(onLogout: _logout),  // Barre latérale avec fonction de déconnexion
      body: stages.isEmpty
          ? Center(child: CircularProgressIndicator()) // Affiche un chargement si aucune donnée
          : ListView.builder(
        itemCount: stages.length,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: AlwaysStoppedAnimation(1),
            child: ListTile(
              title: Text(stages[index]['title']!),
              subtitle: Text('${stages[index]['description']} \nDébut: ${stages[index]['startDate']}'),
              isThreeLine: true,
              contentPadding: EdgeInsets.all(16),
              tileColor: Colors.blue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onTap: () {
                // Vous pouvez ajouter une navigation vers un écran de détails ici
              },
            ),
          );
        },
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final VoidCallback onLogout;

  const AppDrawer({required this.onLogout, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Gérer stages',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A2E),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40), // Ajoute un margin top de 10 pixels

            child:ListTile(
              title: Text('Ajouter un Stage'),

              leading: Icon(Icons.add_chart, color: Colors.black),
              onTap: () {
                // Ajoutez ici la logique pour naviguer vers une page d'ajout de stage
                Navigator.pushNamed(context, '/addInternship');
              },
            ),
          ),

          Container(
            child: ListTile(
              title: Text('modifier un Stage'),
              leading: Icon(Icons.update, color: Colors.black),
              onTap: () {
                // Ajoutez ici la logique pour naviguer vers une page d'ajout de stage
                Navigator.pushNamed(context, '/add_stage');
              },
            ),
          ),
          Container(
            child: ListTile(
                title: Text('Liste des Stage'),
              leading: Icon(Icons.list, color: Colors.black),
              onTap: () {
                // Ajoutez ici la logique pour naviguer vers une page d'ajout de stage
                Navigator.pushNamed(context, '/add_stage');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 400), // Ajoute un margin top de 10 pixels
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('Se Déconnecter'),
              onTap: onLogout,
            ),
          ),

        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Gestion des Stages',
    initialRoute: '/',
    routes: {
      '/': (context) => ListStage(),
      '/login': (context) => ListStage(), // Vous pouvez définir une page de connexion ici
      '/add_stage': (context) => ListStage(), // Vous pouvez définir une page d'ajout de stage ici
    },
  ));
}
