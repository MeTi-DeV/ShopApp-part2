import 'package:flutter/material.dart';
//comment 1 : create a statefulWidget for changeable Form
class EditProductsScreen extends StatefulWidget {
  static const routeName = 'edit_product';
  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  //comment 6 : create a new variable for choose image
  final _imageUrlController = TextEditingController();
//comment 2 : use FocusNode for change between textFields by click on next button on keyboard for this form
  final _priceFocuNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlFocuNode = FocusNode();
  @override
  void initState() {
    _imageUrlFocuNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
    //comment 3 : use dispose() for destroy the data when we complated all text fields and tap on back button on data wil wipe by dispose
  void dispose() {
    _priceFocuNode.dispose();
    _descriptionNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocuNode.dispose();
    _imageUrlFocuNode.removeListener(_updateImageUrl);
    super.dispose();
  }
//comment 7 : create a new function for update image pleace without click on done button on keyboard and use each text fields image will update
  void _updateImageUrl() {
    if (!_imageUrlFocuNode.hasFocus) {
      
    setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                //comment 5 : for use addressfield use FocusScope.of(context).requestFocus(_priceFocuNode) call FocusNodes
                onFieldSubmitted: (_) =>

                    FocusScope.of(context).requestFocus(_priceFocuNode),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                //comment 4 : define our FocusNodes as focusNode here for change between fields
                focusNode: _priceFocuNode,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionNode),
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, right: 10),
                    height:200,
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
                      //comment 8 : for show image changes by this property and set it on setState((){}) for show image
                      onEditingComplete: () {
                        setState(() {});
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
