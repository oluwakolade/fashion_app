import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

Map<String, Color> availableColor = {
  'Red': Colors.red,
  'Blue': Colors.blue,
  'Green': Colors.green,
  'White': Colors.white,
  'Black': Colors.black
};

Color active = Colors.white;
Color passive = Colors.black;
Color activeContainer = const Color(0XFF8E6CEF);
Color passiveContainer = const Color(0XFFF4F4F4);
// bool isSelected = false;

void openColorPicker({
  required BuildContext context,
  required Function(Color) onColorSelected,
  required Color selectedColor,
  // required bool isSelected,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  text: 'Color', fontSize: 18, fontWeight: FontWeight.bold),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String colorName = availableColor.keys.elementAt(index);
                      Color colorValue = availableColor.values.elementAt(index);

                      final isSelected = colorValue == selectedColor;

                      String key = availableColor.keys
                          .elementAt(index); // Get the key at the current index
                      Color value = availableColor[key]!;

                      return ListTile(
                        onTap: () {
                          onColorSelected(colorValue);
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
                            text: colorName,
                            color: isSelected ? active : passive),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 4,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            if (!isSelected) const SizedBox(width: 8),
                            if (isSelected)
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                          height: 10,
                        ),
                    itemCount: availableColor.length),
              )
            ],
          ),
        ),
      );
    },
  );
}
