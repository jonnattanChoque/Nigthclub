import 'package:admin_dashboard/providers/card_provider.dart';
import 'package:admin_dashboard/providers/forms/card_form_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/cards/white_card.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CardProvider>(context, listen: false).getCard();
  }

  @override
  Widget build(BuildContext context) {
    String name = '';
    final cardFormProvider = Provider.of<CardFormProvider>(context);
    final cardProvider = Provider.of<CardProvider>(context);
    final cards = cardProvider.card;

    if(cards.isEmpty) {
      return const LinearProgressIndicator(backgroundColor: Colors.transparent,);
    }
      
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Tarjeta', style: CustomLabels.h1),
          const SizedBox(height: 30),
          WhiteCard(
            title: 'Valor de la tarjeta',
            child: Form(
              key: cardFormProvider.formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => name = value,
                    validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Ingrese el valor';
                        }
                        return null;
                      },
                    initialValue: (cards.isEmpty) ? name : cards[0].name,
                    decoration: CustomInputs.formInputDecoration(
                      hint: 'Valor %', 
                      label: 'Valor de la tarjeta', 
                      icon: Icons.deck_outlined
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 120),
                    child: ElevatedButton(
                      onPressed: () async {
                        final isValid = cardFormProvider.validateForm();
                        if(isValid) {
                          if(cards.isEmpty) {
                            var response = await cardProvider.newCard(name);
                            if(response) {
                              NotificationsService.showSnackBar('Valor creado', false);
                            }
                          } else {
                            var response = await cardProvider.updateCard(name, cards[0].id);
                            if(response) {
                              NotificationsService.showSnackBar('Valor actualizado', false);
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 58, 222, 222)),
                        shadowColor: MaterialStateProperty.all(Colors.transparent)
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.save_outlined, color: Colors.black,),
                          Text('Guardar', style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}
