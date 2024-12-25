import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

// List<Color> availableColor = [
//                   Colors.red,
//                   Colors.pink,
//                   Colors.blue,
//                   Colors.white,
//                   Colors.black];

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
bool isSelected = false;

void openColorPicker({
  required BuildContext context,
  required Function(Color) onColorSelected,
  required Color selectedColor,
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
                  text: 'Color', fontSize: 18, fontWeight: FontWeight.bold),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      String key = availableColor.keys
                          .elementAt(index); // Get the key at the current index
                      Color value = availableColor[key]!;

                      return ListTile(
                        onTap: () {
                          onColorSelected(value);
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
                            text: key, color: isSelected ? active : passive),
                        trailing: Row(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            isSelected
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                          width: 10,
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
