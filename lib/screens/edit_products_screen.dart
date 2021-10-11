import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = 'edit_product';
  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _imageUrlController = TextEditingController();
  final _priceFocuNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlFocuNode = FocusNode();
  //comment 1 : to confirm use Form widget data define a new variable for the storage Form data to itself
  // for this use GlobalKey<FormState>()

  final _form = GlobalKey<FormState>();
  //comment 2 : after define a new variable that its data type is Product
  // with empty values
  var _editedProduct =
      Product(id: '', title: '', imageUrl: '', price: 0, description: '');
  @override
  void initState() {
    _imageUrlFocuNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void dispose() {
    _priceFocuNode.dispose();
    _descriptionNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocuNode.dispose();
    _imageUrlFocuNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocuNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }
//comment 8 : for save values of all text fields  need a function to save them by click on a bottom

  void _saveForm() {
    //comment 14 : after define all of validators here say if one of each fields has an error don't save all of data
    // its happens by define a variable like isSave

    final isSave = _form.currentState!.validate();
    // and in if say if it was not true do nothing
    if (!isSave) {
      return;
    }
    //comment 15 : here we call save() method and its work when if all text fields has correctly  value
    _form.currentState!.save();
    // comment 16 : and after call addProducts() function to add new product to list of all products
    Provider.of<Products>(context, listen: false).addProducts(_editedProduct);
    // and use Navigator.of(context).pop() to close screen and back to previous screen when tap on done button or save button on appBar
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit product'),
        actions: [
          IconButton(onPressed: () => _saveForm(), icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          //comment 3 :here I define a key and it pass data to my _form variable that I defined 
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocuNode),
                    //comment 4 : for save each  data textfields use onSaved:(value){} propety to save
                    // to save value of textfields to our variable like _editedProduct that defined as a empty Product

                onSaved: (value) {
                  _editedProduct = Product(
                      id: '',
                      //comment 5 : for save each parameters of Product widget that we want change  that parameter to value
                      // here i need save title and its String value so change title of Product to : title:value as String,

                      title:value as String,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                focusNode: _priceFocuNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionNode),
                //comment 9 :  for validate each fields create some new if statements
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  //comment 10 : this ifstatement say user have to enter number not words or ...
                  // tryParse(value)== null : this say each entered value that is not a number or double number
                  //should has a value == null  and show an error message
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  //comment 6 : for price  do exactly like title 
                  _editedProduct = Product(
                      id: '',
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      //comment 7 : just different between title and price we have to change value of this textfield from String to double
                      // and pass it to Product or(_editedProduct)
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                      id: '',
                      title: _editedProduct.title,
                      description: value as String,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.length < 10) {
                    return 'Please write 10 characters';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, right: 10),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a Url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocuNode,
                      //comment 12 : for onFieldSubmitted we say wen user tap on done button of keyboard action
                      // save and close this screen
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value as String,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an imageUrl';
                        }
                      //comment 13 : for imageUrl set that should start with http or https
                      // and end with of one these suffix (png or jpeg or jpg)
                        if (!value.startsWith('https') &&
                            !value.startsWith('http')) {
                          return 'Please enter a valid imageUrl';
                        }
                        if (!value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg') &&
                            !value.endsWith('.png')) {
                          return 'Please enter URL with .png , .jpeg or .png';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
