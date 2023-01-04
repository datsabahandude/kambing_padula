import 'package:flutter/material.dart';
import 'kambing.dart';

class KambingDialog extends StatefulWidget {
  final Kambing? kambing;
  final Function(String image, DateTime datenow, String umur, String name, String price, String gender) onClickedDone;
  const KambingDialog({
    Key? key,
    this.kambing,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  State<KambingDialog> createState() => _KambingDialogState();
}

class _KambingDialogState extends State<KambingDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  bool isExpense = true;

  @override
  void initState() {
    super.initState();

    /*if (widget.kambing != null) {
      final kambing = widget.kambing!;

      nameController.text = kambing.name;
      amountController.text = kambing.amount.toString();
      isExpense = kambing.isExpense;
    }*/
  }
  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.kambing != null;
    final title = isEditing ? 'Ubah Maklumat' : 'Tambah Kambing Baru';
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildAmount(),
              SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Name',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Enter a name' : null,
  );

  Widget buildAmount() => TextFormField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Amount',
    ),
    keyboardType: TextInputType.number,
    validator: (amount) => amount != null && double.tryParse(amount) == null
        ? 'Enter a valid number'
        : null,
    controller: amountController,
  );

  Widget buildRadioButtons() => Column(
    children: [
      RadioListTile<bool>(
        title: Text('Expense'),
        value: true,
        groupValue: isExpense,
        onChanged: (value) => setState(() => isExpense = value!),
      ),
      RadioListTile<bool>(
        title: Text('Income'),
        value: false,
        groupValue: isExpense,
        onChanged: (value) => setState(() => isExpense = value!),
      ),
    ],
  );

  Widget buildCancelButton(BuildContext context) => TextButton(
    child: Text('Batal'),
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Simpan' : 'Tambah';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final image = nameController.text;
          final datenow = DateTime.now();
          final price = nameController.text;
          final gender = nameController.text;
          final umur = nameController.text;
          final amount = double.tryParse(amountController.text) ?? 0;

          widget.onClickedDone(image, datenow, umur, name, price, gender);

          Navigator.of(context).pop();
        }
      },
    );
  }
}