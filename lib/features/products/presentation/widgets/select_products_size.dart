import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

List<String> size = ['S', 'M', 'L', 'XL', '2XL'];

Color active = Colors.white;
Color passive = Colors.black;
Color activeContainer = const Color(0XFF8E6CEF);
Color passiveContainer = const Color(0XFFF4F4F4);
bool isSelected = false;

void openSizePicker({
  required BuildContext context,
  required Function(String) onSizeSelected,
  required String selectedSize,
  required bool isSelected,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(10),
              left: Radius.circular(10),
            ),
          ),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppText(
                  text: 'Size', fontSize: 18, fontWeight: FontWeight.bold),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          onSizeSelected(size[index]);
                          Navigator.pop(context);
                        },
                        tileColor:
                            isSelected ? activeContainer : passiveContainer,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        leading: AppText(
                            text: size[index],
                            color: isSelected ? active : passive),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : const SizedBox(),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                          width: 10,
                        ),
                    itemCount: size.length),
              )
            ],
          ),
        ),
      );
    },
  );
}
