import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/forms/login_form_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/shared/buttons/link_text.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false); 

        return Container(
          color: const Color.fromARGB(255, 98, 96, 96),
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                // autovalidateMode: AutovalidateMode.always,
                key: loginFormProvider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onFieldSubmitted: (value) => onFormSubmit(loginFormProvider, authProvider),
                      onChanged: (value) => loginFormProvider.email = value,
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Ingrese correo';
                        } else if(!EmailValidator.validate(value)) {
                          return 'Correo no válido';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su correo',
                        label: 'Correo',
                        icon: Icons.email_outlined
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      onFieldSubmitted: (value) => onFormSubmit(loginFormProvider, authProvider),
                      onChanged: (value) => loginFormProvider.password = value,
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Ingrese contraseña';
                        } else if(value.length < 6) {
                          return 'Debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su contraseña',
                        label: '*******',
                        icon: Icons.lock_outline_rounded
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomOutlineButton(onPressed: () {
                      onFormSubmit(loginFormProvider, authProvider);
                    }, text: 'ingresar', color: Colors.greenAccent, isFilled: true,),
                    const SizedBox(height: 20),
                    LinkText(text: 'Nueva cuenta', onPressed: () {
                      Navigator.pushNamed(context, Flurorouter.registerRouter);
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      })
    );
  }
}

void onFormSubmit(LoginFormProvider lfp, AuthProvider authp) {
  final isValid = lfp.validateForm();
  if(isValid) {
    authp.login(lfp.email, lfp.password);
  }
}