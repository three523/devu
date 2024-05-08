import 'package:devu_app/data/model/label.dart';
import 'package:devu_app/data/resource.dart';
import 'package:devu_app/widget/label_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabelSelectorWidget extends StatefulWidget {
  Function(List<Label>)? onSelecteds;
  List<Label>? selectedList;

  LabelSelectorWidget({Function(List<Label>)? onSelecteds, this.selectedList});

  @override
  State<LabelSelectorWidget> createState() => _LabelSelectorWidgetState();
}

class _LabelSelectorWidgetState extends State<LabelSelectorWidget> {
  List<Label> selectedList = [];
  List<Label> labelList = [
    Label('예금', Colors.red),
    Label('장기체', Colors.deepOrange),
    Label('미국ETF', Colors.green),
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showLabelSelectDialog(context);
      },
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        for (int i = 0; i < selectedList.length; i++)
                          getSelectedLabelWidgett(i, context, setState)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  void showLabelSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text('방법을 선택해주세요'),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: [
                          for (int i = 0; i < labelList.length; i++)
                            getLabelWidget(i, context, setState)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget getSelectedLabelWidgett(
      int index, BuildContext context, Function refresh) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          refresh(() {
            setState(() {
              selectedList.removeAt(index);
            });
          });
        },
        child: LabelWidget(selectedList[index].name, selectedList[index].color),
      ),
    );
  }

  Widget getLabelWidget(int index, BuildContext context, Function refresh) {
    String name = labelList[index].name;

    final isSelected = selectedList.any((element) => element.name == name);

    return GestureDetector(
      onTap: () {
        refresh(() {
          setState(() {
            if (isSelected) {
              selectedList.removeWhere((element) => element.name == name);
            } else {
              selectedList.add(labelList[index]);
            }
          });
        });
      },
      child: LabelWidget(labelList[index].name,
          isSelected ? labelList[index].color : disableButtonColor),
    );
  }
}
