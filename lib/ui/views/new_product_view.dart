import 'dart:convert';
import 'package:admin_dashboard/providers/forms/product_form_provider.dart';
import 'package:admin_dashboard/providers/products_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/cards/white_card.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:admin_dashboard/utils/local_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NewProductView extends StatefulWidget {
  const NewProductView({Key? key}) : super(key: key);

  @override
  State<NewProductView> createState() => _NewProductViewState();
}

class _NewProductViewState extends State<NewProductView> {
  String? name;
  String? price;
  String? image;
  String dropdownValue = 'Seleccione';
  List<String> listCategories = ['a', 'b'];
  ImageProvider<Object> newImage = const AssetImage('no-image.jpg');

  @override
  void initState() {
    super.initState();
    final jsonString = LocalStorage().getInternalCategory() as String;
    listCategories = jsonString.replaceAll(',', '').replaceAll('[', '').replaceAll(']', '').split(' ');
    listCategories.insert(0, dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Crear producto', style: CustomLabels.h1),
          const SizedBox(height: 30),
            Table(
              columnWidths: const {
                0: FixedColumnWidth(250)
              },
              children: [
                TableRow(
                  children: [
                    WhiteCard(
                      width: 250,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Imagen', style: CustomLabels.h2),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 150,
                              height: 160,
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: Image(image: newImage),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: Colors.white, width: 5)
                                      ),
                                      child: FloatingActionButton(
                                        heroTag: 'buttonNewProduct',
                                        backgroundColor: Colors.indigo,
                                        child: const Icon(Icons.camera_alt_outlined, size: 20,),
                                        onPressed: () async {
                                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                                            allowMultiple: false,
                                            allowCompression: true
                                          );

                                          if (result != null) {
                                            PlatformFile file = result.files.first;
                                            setState(() {
                                              newImage = Image.memory(file.bytes!).image;
                                              String base64string = base64.encode(file.bytes!);
                                              image = base64string;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ),
                    WhiteCard(
                      title: "Productos",
                      child: Form(
                        key: productFormProvider.formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value == 'Seleccione') return 'Seleccione una categoría';
                                return null;
                              },
                              isExpanded: true,
                              decoration: CustomInputs.formInputDecoration(
                                hint: 'Categoría',
                                label: 'Categoría',
                                icon: Icons.category_outlined
                              ),
                              value: dropdownValue,
                              items: listCategories
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              decoration: CustomInputs.formInputDecoration(
                                hint: 'Nombre de producto',
                                label: 'Nombre',
                                icon: Icons.production_quantity_limits_outlined
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Ingrese un nombre';
                                if (value.length < 2) return 'Ingrese un nombre mayor de 2 letras';
                                return null;
                              },
                              onChanged: (value) => name = value,
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              decoration: CustomInputs.formInputDecoration(
                                hint: 'Precio de producto',
                                label: 'Precio',
                                icon: Icons.price_check_outlined
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Ingrese un precio';
                                return null;
                              },
                              onChanged: (value) => price = value,
                            ),
                            const SizedBox(height: 20),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 120),
                              child: ElevatedButton(
                                onPressed: () {
                                  onFormSubmit(productFormProvider, dropdownValue, name ?? "", price ?? "", image ?? "", productsProvider);
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
                        )
                      ),
                    )
                  ]
                )
              ],
            )
        ],
      )
    );
  }
}


void onFormSubmit(ProductFormProvider lfp, String category, String name, String price, String image, ProductsProvider prodp) async {
  final isValid = lfp.validateForm();
  if(isValid && name.isNotEmpty && price.isNotEmpty) {
    final create = await prodp.newProduct(category, name, price, image);
    if (create) {
      NotificationsService.showSnackBar('Producto creado', false);
      Future.delayed(Duration.zero, () {
        NavigationService.replaceTo(Flurorouter.productsRouter);
      });
    }
  }
}