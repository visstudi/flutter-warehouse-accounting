import 'package:flutter/material.dart';
import 'package:sandbox_app1/models/goods.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddGoodsPage extends StatefulWidget {
  const new({super.key});

  @override
  State<AddGoodsPage> createState() => _AddGoodsPageState();
}

class _AddGoodsPageState extends State<AddGoodsPage> {
  final _formKey = GlobalKey<FormState>();

  String _goodsName = "";
  String _goodsDescription = "";

  void _showQRDialog(String name, String description) {
    AlertDialog qr = AlertDialog(
      backgroundColor: Colors.grey[200],
      content: SizedBox(
        width: 300,
        child: QrImageView(
          data: "$name;$description",
          version: QrVersions.auto,
          backgroundColor: Colors.grey[200] ?? Colors.grey,
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Закрыть"),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => qr);
  }

  bool _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    }
    return false;
  }

  void _submitForm() {
    if (_saveForm()) {
      tempGoodsList.add(
        Goods(
          name: _goodsName,
          description: _goodsDescription,
          imagePath: "lib/images/placeholder.png",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Добавление товара",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 20,
                        children: [
                          // Goods name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Text(
                                "Название товара:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return "Введите название товара";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => _goodsName = newValue!,
                                decoration: InputDecoration(
                                  hint: Text("Название товара"),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Goods description
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Text(
                                "Описание товара:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormField(
                                onSaved: (newValue) =>
                                    _goodsDescription = newValue!,
                                decoration: InputDecoration(
                                  hint: Text("Описание товара"),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                maxLines: 10,
                                minLines: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Назад"),
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_saveForm()) {
                        _showQRDialog(_goodsName, _goodsDescription);
                      }
                    },
                    child: Icon(Icons.qr_code),
                  ),
                  FilledButton(onPressed: _submitForm, child: Text("Добавить")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
