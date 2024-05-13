import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/data/resource.dart';
import 'package:devu_app/page/add_label_page.dart';
import 'package:devu_app/widget/label_widget.dart';
import 'package:flutter/material.dart';

class LabelSelectorWidget extends StatefulWidget {
  Function(List<Tag>)? onSelecteds;
  List<Tag> selectedList;

  LabelSelectorWidget({Function(List<Tag>)? this.onSelecteds, selectedList})
      : selectedList = selectedList ?? [];

  @override
  State<LabelSelectorWidget> createState() => _LabelSelectorWidgetState();
}

class _LabelSelectorWidgetState extends State<LabelSelectorWidget> {
  List<Tag> labelList = [
    Tag('예금', Colors.red.value),
    Tag('장기체', Colors.deepOrange.value),
    Tag('미국ETF', Colors.green.value),
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
                        for (int i = 0; i < widget.selectedList.length; i++)
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
          builder: (BuildContext context,
              void Function(void Function()) dialogSetState) {
            return Dialog(
              backgroundColor: Colors.white,
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
                            getLabelWidget(i, context, dialogSetState)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          final List<Tag> newLabelList = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddLabelPage(
                                labelList,
                                (newLabelList) {
                                  dialogSetState(
                                    () {
                                      setState(() {
                                        labelList = newLabelList;
                                        List<Tag> newSelectedList = widget
                                            .selectedList
                                            .where((element) =>
                                                labelList.contains(element))
                                            .toList();
                                        widget.selectedList = newSelectedList;
                                        if (widget.onSelecteds != null) {
                                          widget.onSelecteds!(
                                              widget.selectedList);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                          labelList = newLabelList;
                        },
                        child: Text(
                          '태그 생성하러가기 >',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            backgroundColor: primaryColor),
                        onPressed: () {
                          print('add taglist${widget.selectedList}');
                          if (widget.onSelecteds != null) {
                            widget.onSelecteds!(widget.selectedList);
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
              widget.selectedList.removeAt(index);
              if (widget.onSelecteds != null) {
                print('label seletedWidget:${widget.onSelecteds}');
                widget.onSelecteds!(widget.selectedList);
              }
            });
          });
        },
        child: LabelWidget(widget.selectedList[index].name,
            Color(widget.selectedList[index].color)),
      ),
    );
  }

  Widget getLabelWidget(int index, BuildContext context, Function refresh) {
    final String name = labelList[index].name;
    final Color color = Color(labelList[index].color);

    final isSelected =
        widget.selectedList.any((element) => element.name == name);

    return GestureDetector(
      onTap: () {
        refresh(() {
          setState(() {
            if (isSelected) {
              widget.selectedList
                  .removeWhere((element) => element.name == name);
            } else {
              widget.selectedList.add(labelList[index]);
            }
            if (widget.onSelecteds != null) {
              print('label:${widget.onSelecteds}');
              widget.onSelecteds!(widget.selectedList);
            }
          });
        });
      },
      child: LabelWidget(name, isSelected ? color : disableButtonColor),
    );
  }
}
