// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:onboarding_app/presentation/viewmodels/auth_viewmodel.dart';
//
// class LoginPage extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final authVM = Provider.of<AuthViewModel>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) => value!.contains('@') ? null : 'Invalid email',
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) => value!.length >= 6 ? null : 'Password too short',
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     final success = await authVM.login(
//                       _emailController.text,
//                       _passwordController.text,
//                     );
//                     if (success) {
//                       Navigator.pushReplacementNamed(context, '/home');
//                     }
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pushNamed(context, '/register'),
//                 child: Text('Create Account'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:maktabati_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.contains('@') ? null : 'Enter a valid email',
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.length >= 6 ? null : 'Password must be at least 6 characters',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await authVM.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (success) {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}