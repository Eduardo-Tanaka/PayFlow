import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nlw2021/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:nlw2021/shared/themes/app_colors.dart';
import 'package:nlw2021/shared/themes/app_text_styles.dart';
import 'package:nlw2021/shared/widgets/input_text/input_text_widget.dart';
import 'package:nlw2021/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final nameInputTextController = TextEditingController();
  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );
  final dueDateInputTextController = MaskedTextController(
    mask: "00/00/0000",
  );
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      nameInputTextController.text = "IPTU";
      // formato para IPTU, outros tipos de boleto têm padrão diferente
      if (widget.barcode!.length == 48) {
        moneyInputTextController.text = widget.barcode!.substring(5, 11) +
            widget.barcode!.substring(12, 16);
        dueDateInputTextController.text = widget.barcode!.substring(20, 22) +
            "/" +
            widget.barcode!.substring(22, 23) +
            widget.barcode!.substring(24, 25) +
            "/20" +
            widget.barcode!.substring(25, 27);
      } else {
        // lendo pela câmera ele retira o último dígito de cada parte
        moneyInputTextController.text = widget.barcode!.substring(5, 15);
        dueDateInputTextController.text = widget.barcode!.substring(19, 21) +
            "/" +
            widget.barcode!.substring(21, 24) +
            "/20" +
            widget.barcode!.substring(24, 26);
      }

      barcodeInputTextController.text = widget.barcode!;

      controller.onChange(
        barcode: barcodeInputTextController.text,
        dueDate: dueDateInputTextController.text,
        name: nameInputTextController.text,
        value: moneyInputTextController.numberValue,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 93,
                ),
                child: Text(
                  "Preencha os dados do boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      controller: nameInputTextController,
                      label: "Nome do boleto",
                      validator: controller.validateName,
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChange(name: value);
                      },
                    ),
                    InputTextWidget(
                      controller: dueDateInputTextController,
                      label: "Vencimento",
                      validator: controller.validateVencimento,
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller.onChange(dueDate: value);
                      },
                      textInputType: TextInputType.number,
                    ),
                    InputTextWidget(
                      controller: moneyInputTextController,
                      label: "Valor",
                      validator: (_) => controller.validateValor(
                        moneyInputTextController.numberValue,
                      ),
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        controller.onChange(
                          value: moneyInputTextController.numberValue,
                        );
                      },
                      textInputType: TextInputType.number,
                    ),
                    InputTextWidget(
                      controller: barcodeInputTextController,
                      label: "Código",
                      validator: controller.validateCodigo,
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        controller.onChange(barcode: value);
                      },
                      textInputType: TextInputType.number,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryLabel: "Cancelar",
        primaryPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: "Cadastrar",
        secondaryPressed: () async {
          await controller.cadastrarBoleto();
          Navigator.pop(context);
        },
        enableSecondaryColor: true,
      ),
    );
  }
}
