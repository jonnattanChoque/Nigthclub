import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/forms/register_form_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/shared/buttons/link_text.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false); 
      
        return Container(
          color: Colors.black,
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: registerFormProvider.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => registerFormProvider.email = value,
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Ingrese nombre';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su nombre',
                        label: 'Nombre',
                        icon: Icons.supervised_user_circle_sharp
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      onChanged: (value) => registerFormProvider.email = value,
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
                      onChanged: (value) => registerFormProvider.password = value,
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
                      final isValid = registerFormProvider.validateForm();
                      if(isValid) {
                        authProvider.register(registerFormProvider.email, registerFormProvider.password);
                      }
                    }, text: 'Crear cuenta', color: Colors.greenAccent, isFilled: true,),
                    const SizedBox(height: 20),
                    LinkText(text: 'Ir al login', onPressed: () {
                      Navigator.pushNamed(context, Flurorouter.loginRouter);
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}