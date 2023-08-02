import 'dart:convert';
import 'dart:typed_data';

import 'package:admin_dashboard/models/product_model.dart';
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
import 'package:provider/provider.dart';

class ProductIDView extends StatefulWidget {
  final String uid;
  const ProductIDView({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProductIDView> createState() => _ProductIDViewState();
}

class _ProductIDViewState extends State<ProductIDView> {
  Products? product;
  ImageProvider<Object> newImage = const AssetImage('no-image.jpg');
  String dropdownValue = 'Seleccione';
  List<String> listCategories = ['a', 'b'];
  
  @override
  void initState() {
    super.initState();
    final productProvider = Provider.of<ProductsProvider>(context, listen: false);
    final productFormProvider = Provider.of<ProductFormProvider>(context, listen: false);
    final productID = productProvider.getProductsById(widget.uid);

    final jsonString = LocalStorage().getInternalCategory() as String;
    listCategories = jsonString.replaceAll(',', '').replaceAll('[', '').replaceAll(']', '').split(' ');
    listCategories.insert(0, dropdownValue);
    
    if(productID == 0) {
      Future.delayed(Duration.zero, () {
        NavigationService.replaceTo(Flurorouter.productsRouter);
      });
    } else {
      setState(() {
        product = productID.first;
        productFormProvider.product = product;
        
        if(product!.image.isNotEmpty) {
          Uint8List decodedbytes = base64.decode(product!.image);
          newImage = Image.memory(decodedbytes).image;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Title', style: CustomLabels.h1),
          const SizedBox(height: 30),
          if(product == null ) 
            WhiteCard(
              child: Container(
                alignment: Alignment.center,
                height: 300,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          if(product != null )
            _ProductVIewBody(nameProduct: product?.name, newImage: newImage, categoryProduct: product?.category, listCategories: listCategories)
        ],
      )
    );
  }
}

class _ProductVIewBody extends StatelessWidget {
  final String? nameProduct;
  final String? categoryProduct;
  final ImageProvider<Object> newImage;
  final List<String> listCategories;

  const _ProductVIewBody({
    required this.newImage,
    required this.categoryProduct,
    this.nameProduct, required this.listCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(250)
      },
      children: [
        TableRow(
          children: [
            _ImageProduct(name: nameProduct, newImage: newImage ),
            _ProductViewForm(dropdownValue: categoryProduct ?? '', listCategories: listCategories)
          ]
        )
      ],
    );
  }
}

class _ProductViewForm extends StatefulWidget {
  final String dropdownValue;
  final List<String> listCategories;

  const _ProductViewForm({Key? key, required this.dropdownValue, required this.listCategories}) : super(key: key);

  @override
  State<_ProductViewForm> createState() => _ProductViewFormState();
}

class _ProductViewFormState extends State<_ProductViewForm> {

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;
  
    return WhiteCard(
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
              value: widget.dropdownValue,
              items: widget.listCategories
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
                  productFormProvider.product?.category = newValue!;
                });
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              initialValue: product?.name,
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
              onChanged: (value) => productFormProvider.product?.name = value,
            ),
            const SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: product?.price,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Precio de producto',
                label: 'Precio',
                icon: Icons.price_check_outlined
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Ingrese un precio';
                return null;
              },
              onChanged: (value) => productFormProvider.product?.price = value,
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 120),
              child: ElevatedButton(
                onPressed: () {
                  onFormSubmit(productFormProvider, productsProvider);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  shadowColor: MaterialStateProperty.all(Colors.transparent)
                ),
                child: const Row(
                  children: [
                    Icon(Icons.save_outlined, color: Colors.white,),
                    Text('Guardar', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

// ignore: must_be_immutable
class _ImageProduct extends StatefulWidget {
  final String? name;
  ImageProvider<Object> newImage;

  _ImageProduct({
    required this.newImage,
    this.name,
  });

  @override
  State<_ImageProduct> createState() => _ImageProductState();
}

class _ImageProductState extends State<_ImageProduct> {

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    return WhiteCard(
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
                    child: Image(image: widget.newImage),
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
                        heroTag: 'productUpdate',
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
                              widget.newImage = Image.memory(file.bytes!).image;
                              String base64string = base64.encode(file.bytes!);
                              productFormProvider.product?.image = base64string;
                            });
                          }
                        },
                      ),
                    ),
                  )
                ],
              )
            ),
            const SizedBox(height: 20),
            Text(widget.name ?? "", style: const TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

void onFormSubmit(ProductFormProvider lfp, ProductsProvider prodp) async {
  final isValid = lfp.validateForm();
  if(isValid) {
    final update = await prodp.updateProduct(lfp.product?.category ?? "", lfp.product?.name ?? "", lfp.product?.price ?? "", lfp.product?.image ?? "", lfp.product?.id ?? "");
    if (update) {
      NotificationsService.showSnackBar('Producto actualizado', false);
      Future.delayed(Duration.zero, () {
        NavigationService.replaceTo(Flurorouter.productsRouter);
      });
    }
  }
}