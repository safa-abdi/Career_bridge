import 'package:flutter/material.dart';

class JobDashboard extends StatefulWidget {
  const JobDashboard({Key? key}) : super(key: key);

  @override
  _JobDashboardState createState() => _JobDashboardState();
}

class _JobDashboardState extends State<JobDashboard> with TickerProviderStateMixin {
  double _scale = 1.0;

  // Animation Controller pour l'apparition des éléments
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(); // Lancer l'animation dès le début
  }

  // Fonction pour changer la taille au survol
  void _onHoverEnter() {
    setState(() {
      _scale = 1.1;
    });
  }

  // Fonction pour réinitialiser la taille
  void _onHoverExit() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Dashboard Entreprise',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 40, // Taille du cercle
              backgroundImage: NetworkImage('https://www.example.com/path_to_your_profile_image.jpg'),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SlideTransition(
          position: _animation,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: _scale,
                child: MouseRegion(
                  onEnter: (_) => _onHoverEnter(),
                  onExit: (_) => _onHoverExit(),
                  child: GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.pushNamed(context, '/listStages');
                          break;
                        case 1:
                          print('Voir les offres');
                          break;
                        case 2:
                          print('Gérer les candidatures');
                          break;
                        case 3:
                          print('Statistiques');
                          break;
                        case 4:
                          print('Messages');
                          break;
                        case 5:
                          print('Paramètres');
                          break;
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 8.0,
                      shadowColor: Colors.black.withOpacity(0.3),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF1A1A2E), // Bleu nuit
                              Color(0xFF252C4A), // Gris foncé
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIconForIndex(index),
                              size: 50.0,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              _getTitleForIndex(index),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      // Barre de déconnexion en bas avec logo
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            print('Déconnexion');
            // Ajoutez ici la logique de déconnexion
          },
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Color(0xFF1A1A2E), // Couleur de fond de la barre
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.exit_to_app, color: Colors.white), // Logo de déconnexion
                const SizedBox(width: 8.0),
                const Text(
                  'Se déconnecter',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Gérer les stages';
      case 1:
        return 'Voir les offres';
      case 2:
        return 'Gérer les candidatures';
      case 3:
        return 'Statistiques';
      case 4:
        return 'Messages';
      case 5:
        return 'Paramètres';
      default:
        return '';
    }
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:

        return Icons.business;
      case 1:
        return Icons.work;
      case 2:
        return Icons.assignment;
      case 3:
        return Icons.bar_chart;
      case 4:
        return Icons.message;
      case 5:
        return Icons.settings;
      default:
        return Icons.help;
    }
  }
}
