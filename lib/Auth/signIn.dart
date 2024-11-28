import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isStudent = true;

  // Controlleurs pour récupérer les valeurs saisies
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Clé pour valider le formulaire

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    studentIdController.dispose();
    companyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            /// Bouton pour changer le type d'utilisateur (Étudiant/Entreprise)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isStudent = true;
                    });
                  },
                  child: Text(
                    "Student",
                    style: TextStyle(
                      fontWeight:
                          isStudent ? FontWeight.bold : FontWeight.normal,
                      color: isStudent ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isStudent = false;
                    });
                  },
                  child: Text(
                    "Company",
                    style: TextStyle(
                      fontWeight:
                          !isStudent ? FontWeight.bold : FontWeight.normal,
                      color: !isStudent ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            /// Affichage du formulaire selon le type d'utilisateur
            Form(
              key: _formKey, // Associe le formulaire à la clé
              child: isStudent
                  ? _buildStudentForm(context)
                  : _buildCompanyForm(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Formulaire pour les étudiants
  Widget _buildStudentForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                .hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Si le formulaire est valide, naviguer vers la page Home
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text('Login as Student'),
        ),
        const SizedBox(height: 16),
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signUp');
          },
          child: const Text("Sign Up"),
        ),
      ],
    );
  }

  /// Formulaire pour les entreprises
  Widget _buildCompanyForm(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                .hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Si le formulaire est valide, naviguer vers la page Home
              Navigator.pushReplacementNamed(context, '/dashboardEbtreprise');
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text('Login as Company'),
        ),
        const SizedBox(height: 16),
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signUp');
          },
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}
