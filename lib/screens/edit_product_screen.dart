import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/products.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  TextEditingController imageController = TextEditingController();

  Product editProduct = Product(
    id: '',
    image: '',
    title: '',
    price: 0.0,
    description: '',
    quantity: 0,
    color: Colors.transparent,
    isFavorite: false,
  );
  var initialValue = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'image': '',
  };
  bool isLoading = false;
  String submitError = '';
  //Update Product and Add Product
  Future<void> _onFormSubmit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _updateImagePath();
    _form.currentState!.save();
    setState(() {
      isLoading = true;
    });
    final productsData = Provider.of<Products>(context, listen: false);
    if (editProduct.id.isEmpty) {
      try {
        await productsData.addProduct(editProduct);
      } catch (e) {
        await showErrorDialog();
      }
      // finally {}
    } else {
      await productsData.updateProduct(editProduct.id, editProduct);
    }
    setState(() {
      isLoading = false;
    });
    navigatePopScreen();
  }

  void navigatePopScreen() {
    Navigator.pop(context);
  }

  Future<void> showErrorDialog() {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Error submit form data'),
          content: const Text('Intrenet connection fail!'),
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImagePath);
    super.initState();
  }

  void _updateImagePath() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImagePath);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // if (ModalRoute.of(context)?.settings.arguments == null) {
    //   return;
    // }
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    if (productId.isNotEmpty) {
      Product product =
          Provider.of<Products>(context).findProductById(productId);
      editProduct = product;

      initialValue = {
        'id': editProduct.id,
        'image': editProduct.image,
        'title': editProduct.title,
        'price': editProduct.price.toString(),
        'description': editProduct.description,
      };
    }
    imageController.text = initialValue['image']!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
              onPressed: () {
                _onFormSubmit();
              },
              icon: const Icon(
                Icons.save,
                color: Colors.purple,
                size: 30,
              ))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    TextFormField(
                      initialValue: initialValue['title'],
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'require field title is empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editProduct = Product(
                          id: editProduct.id,
                          image: editProduct.image,
                          title: value!,
                          price: editProduct.price,
                          description: editProduct.description,
                          quantity: editProduct.quantity,
                          color: editProduct.color,
                          isFavorite: editProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: initialValue['price'],
                      decoration: const InputDecoration(
                        label: Text('Price'),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (double.tryParse(value!) == null) {
                          return 'price must be number!';
                        }
                        if (double.parse(value) <= 0) {
                          return 'price must be greather than 0!';
                        }
                        if (value.isEmpty) {
                          return 'price must be empty price!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editProduct = Product(
                          id: editProduct.id,
                          image: editProduct.image,
                          title: editProduct.title,
                          price: double.parse(value!),
                          description: editProduct.description,
                          quantity: editProduct.quantity,
                          color: editProduct.color,
                          isFavorite: editProduct.isFavorite,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: initialValue['description'],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'required field description is empty!';
                        }
                        if (value.length < 10) {
                          return 'descrtion is there are 10 words';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      onSaved: (value) {
                        editProduct = Product(
                          id: editProduct.id,
                          image: value!,
                          title: editProduct.title,
                          price: editProduct.price,
                          description: value,
                          quantity: editProduct.quantity,
                          color: editProduct.color,
                          isFavorite: editProduct.isFavorite,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: imageController.text.isEmpty
                              ? Image.network(
                                  'https://www.russorizio.com/wp-content/uploads/2016/07/ef3-placeholder-image.jpg',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  imageController.text,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: imageController,
                            focusNode: _imageFocusNode,
                            decoration: const InputDecoration(
                              labelText: 'Image',
                            ),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              _onFormSubmit();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                value =
                                    'https://www.russorizio.com/wp-content/uploads/2016/07/ef3-placeholder-image.jpg';
                              }
                              if (value.endsWith('png') &&
                                  value.endsWith('jpg') &&
                                  value.endsWith('webp') &&
                                  value.endsWith('jpeg')) {
                                return 'invalid image';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              editProduct = Product(
                                id: editProduct.id,
                                image: value!,
                                title: editProduct.title,
                                price: editProduct.price,
                                description: editProduct.description,
                                quantity: editProduct.quantity,
                                color: editProduct.color,
                                isFavorite: editProduct.isFavorite,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
