import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_ecommerce/models/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class productOperation extends StatefulWidget {
  Product? product;
  productOperation({this.product});

  @override
  State<productOperation> createState() => _productOperationState();
}

class _productOperationState extends State<productOperation> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ImagePicker _imgProduto = ImagePicker();

  File? _imageProduct;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _titleController.text = widget.product!.title;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _imageProduct = widget.product!.imageProduct;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product != null ? "Editar Produto" : "Cadastro de Produtos",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
          backgroundColor: widget.product != null
              ? Colors.blueAccent
              : Colors.greenAccent[700],
          centerTitle: true,
        ),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () async {
                      final XFile? pickedFile = await _imgProduto.pickImage(
                        source: ImageSource.camera,
                      );
                      if (pickedFile != null) {
                        final File imagePicked = File(pickedFile.path);
                        Directory dir =
                            await getApplicationDocumentsDirectory();
                        String localPath = dir.path;
                        String idImage = UniqueKey().toString();
                        final File pathImageSave = await imagePicked.copy(
                          "$localPath/img_$idImage.png",
                        );
                        setState(() {
                          _imageProduct = pathImageSave;
                        });
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: widget.product != null
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: widget.product != null
                              ? Colors.blue
                              : Colors.green,
                          width: 3,
                        ),
                      ),
                      child: _imageProduct != null
                          ? Image.file(
                              _imageProduct!,
                              fit: BoxFit
                                  .cover, // Controla o "fix" (ajuste da imagem)
                              width: 150,
                              height: 150,
                            )
                          : Icon(Icons.add_a_photo, size: 40),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          "Titulo",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: widget.product != null
                                ? Colors.blueAccent
                                : Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: widget.product != null
                                  ? Colors.blueAccent
                                  : Colors.green,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: widget.product != null
                                  ? Colors.blueAccent
                                  : Colors.green,
                              width: 2.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 3),
                          ),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo Obrigatório";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          "Descrição",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: widget.product != null
                                ? Colors.blueAccent
                                : Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: widget.product != null
                                  ? Colors.blueAccent
                                  : Colors.green,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: widget.product != null
                                  ? Colors.blueAccent
                                  : Colors.green,
                              width: 2.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 3),
                          ),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo Obrigatório";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          "Valor",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: widget.product != null
                                ? Colors.blueAccent
                                : Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*[,\.]?\d*'),
                          ),
                        ],
                        decoration: InputDecoration(
                          prefixText: "R\$ ",
                          prefixStyle: TextStyle(
                            color: widget.product != null
                                ? Colors.blueAccent
                                : Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: widget.product != null
                                  ? Colors.blueAccent
                                  : Colors.green,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: widget.product != null
                                  ? Colors.blueAccent
                                  : Colors.green,
                              width: 3,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo Obrigatório";
                          }
                          value = value.replaceAll(',', '.');
                          if (double.tryParse(value) == null) {
                            return "Digite um valor válido";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formkey.currentState!.validate()) {
                                double priceValid = double.parse(
                                  _priceController.text.replaceAll(",", "."),
                                );

                                String title = _titleController.text.toString();
                                String description = _descriptionController.text
                                    .toString();
                                double price = priceValid;

                                Product newProduct = Product(
                                  title,
                                  description,
                                  price,
                                  imageProduct: _imageProduct,
                                  id: widget.product?.id,
                                );

                                Navigator.pop(context, newProduct);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.product != null
                                  ? Colors.blueAccent
                                  : Colors.greenAccent[700],
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              widget.product != null ? "Editar" : "Cadastrar",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                            child: Text("Cancelar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
