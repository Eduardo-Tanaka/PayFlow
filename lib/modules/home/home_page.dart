import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nlw2021/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:nlw2021/modules/extract/extract_page.dart';
import 'package:nlw2021/shared/models/user_model.dart';
import 'package:nlw2021/shared/widgets/input_text/input_text_widget.dart';
import 'package:nlw2021/shared/widgets/label_button/label_button.dart';
import 'package:nlw2021/shared/widgets/set_label_buttons/set_label_buttons.dart';

import 'home_controller.dart';
import 'package:flutter/material.dart';
import 'package:nlw2021/modules/meus_boletos/meus_boletos_page.dart';
import 'package:nlw2021/shared/themes/app_colors.dart';
import 'package:nlw2021/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final controller = BarcodeScannerController();
  final codigoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: "Olá ",
                  style: TextStyles.titleRegular,
                  children: [
                    TextSpan(
                        text: "${widget.user.name}",
                        style: TextStyles.titleBoldBackground)
                  ],
                ),
              ),
              subtitle: Text(
                "Mantenha suas contas em dia",
                style: TextStyles.captionShape,
              ),
              trailing: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.user.photoUrl!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MeusBoletosPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        ),
      ][homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                homeController.setPage(0);
                setState(() {});
              },
              icon: Icon(
                Icons.home,
                color: homeController.currentPage == 0
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    child: Wrap(
                      children: [
                        ListTile(
                          title: Text("Digitar código"),
                          leading: Icon(Icons.border_color),
                          onTap: () => {
                            Navigator.pop(context),
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Digite o código de barras'),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 40,
                                      bottom: 20,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: TextFormField(
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          isDense: true,
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: codigoController,
                                      ),
                                    ),
                                  ),
                                  SetLabelButtons(
                                    primaryLabel: "Cancelar",
                                    primaryPressed: () {
                                      Navigator.pop(context);
                                    },
                                    secondaryLabel: "Cadastrar",
                                    secondaryPressed: () async {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                        context,
                                        "/insert_boleto",
                                        arguments: codigoController.text,
                                      ).then((value) => setState(() {}));
                                    },
                                    enableSecondaryColor: true,
                                  ),
                                ],
                              ),
                            )
                          },
                        ),
                        ListTile(
                            title: Text("Escanear código"),
                            leading: Icon(Icons.camera_alt),
                            onTap: () async {
                              Navigator.pop(context);
                              await Navigator.pushNamed(
                                context,
                                "/barcode_scanner",
                              ).then((value) => setState(() {}));
                            }),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                homeController.setPage(1);
                setState(() {});
              },
              icon: Icon(
                Icons.description_outlined,
                color: homeController.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
