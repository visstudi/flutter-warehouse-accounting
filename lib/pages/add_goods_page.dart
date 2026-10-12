import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandbox_app1/components/qr_dialog.dart';
import 'package:sandbox_app1/models/goods.dart';
import 'package:sandbox_app1/pages/qr_scanner_page.dart';

List<(GoodsStatus, String)> goodsStatusOptions = [
  (GoodsStatus.free, 'Свободен'),
  (GoodsStatus.taken, 'Занят'),
];

class AddGoodsPage extends StatefulWidget {
  const new({super.key});

  @override
  State<AddGoodsPage> createState() => _AddGoodsPageState();
}

class _AddGoodsPageState extends State<AddGoodsPage> {
  final _formKey = GlobalKey<FormState>();

  String _goodsName = "";
  String _goodsDescription = "";
  Set<GoodsStatus> _goodsStatus = {GoodsStatus.free};

  bool _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _formKey.currentState!.reset();
      return true;
    }
    return false;
  }

  void _submitForm() {
    if (_saveForm()) {
      Provider.of<GoodsListModel>(context, listen: false).add(
        Goods(
          name: _goodsName,
          description: _goodsDescription,
          imagePath: "lib/images/placeholder.png",
          status: _goodsStatus.first,
        ),
      );
    }
  }

  Future<void> _scanGoodsQr() async {
    final (String? goodsName, String? goodsDesc) =
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QrScannerPage()),
        ) ??
        (null, null);

    if (!context.mounted) return;
    if (goodsName == null || goodsDesc == null) return;

    setState(() {
      _goodsName = goodsName;
      _goodsDescription = goodsDesc;
    });

    Provider.of<GoodsListModel>(context, listen: false).add(
      Goods(
        name: _goodsName,
        description: _goodsDescription,
        imagePath: "lib/images/placeholder.png",
      ),
    );

    Navigator.pop(context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Добавление товара",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: _scanGoodsQr,
                    icon: Icon(Icons.qr_code_scanner),
                  ),
                ],
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

                          // Goods status
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                "Статус:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SegmentedButton(
                                style: SegmentedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  foregroundColor: Colors.black,
                                  selectedBackgroundColor:
                                      (_goodsStatus.first == GoodsStatus.free)
                                      ? Colors.green
                                      : Colors.red,
                                  selectedForegroundColor: Colors.white,
                                ),
                                showSelectedIcon: false,
                                selected: _goodsStatus,
                                onSelectionChanged:
                                    (Set<GoodsStatus> newStatus) {
                                      setState(() {
                                        _goodsStatus = newStatus;
                                      });
                                    },
                                segments: goodsStatusOptions
                                    .map<ButtonSegment<GoodsStatus>>((
                                      (GoodsStatus, String) status,
                                    ) {
                                      return ButtonSegment(
                                        value: status.$1,
                                        label: Text(status.$2),
                                      );
                                    })
                                    .toList(),
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
                        QRDialog.showQRDialog(
                          context,
                          _goodsName,
                          _goodsDescription,
                        );
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
