import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/tag_bloc.dart';
import 'package:devu_app/tag_event.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/default_button.dart';
import 'package:devu_app/widget/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLabelPage extends StatefulWidget {
  List<Tag> labelList;
  Function(List<Tag>) updateList;
  AddLabelPage(this.labelList, this.updateList);
  @override
  State<AddLabelPage> createState() => _AddLabelPageState();
}

class _AddLabelPageState extends State<AddLabelPage> {
  List<Color> colorList = [
    Colors.black,
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.indigo,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime,
    Colors.orange,
    Colors.pink,
    Colors.red,
    Colors.teal,
    Colors.yellow
  ];

  Color? selectedColor;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('태그 업데이트'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                for (int i = 0; i < widget.labelList.length; i++)
                  getLabelWidget(i)
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              '레이블 이름 입력',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
            ),
            SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: textEditingController,
              maxLength: 10,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < colorList.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedColor = colorList[i];
                            });
                          },
                          child: selectedColor != null &&
                                  selectedColor! == colorList[i]
                              ? Icon(
                                  Icons.check,
                                  color:
                                      getTextColorForBackground(colorList[i]),
                                )
                              : null,
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStateProperty.all(colorList[i]),
                            shape: MaterialStateProperty.all(
                              CircleBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            SizedBox(
              width: double.infinity,
              child: DefaultButton(
                '추가하기',
                addLabel,
              ),
            )
          ],
        ),
      ),
    );
  }

  void addLabel() {
    final name = textEditingController.text.replaceAll(' ', '');
    final color = selectedColor;
    if (validate(name, color) && !isExisLabel(name)) {
      setState(() {
        createTag(Tag(name, color!.value));
        widget.labelList.add(Tag(name, color.value));
        widget.updateList(widget.labelList);
      });
    }
  }

  bool validate(String name, Color? color) {
    bool isTextEmpty = name.isEmpty;
    if (isTextEmpty) {
      print('텍스트를 입력해야합니다.');
      return false;
    }
    bool isColorSelected = selectedColor != null;
    if (!isColorSelected) {
      print('컬러 색상을 선택해야합니다.');
      return false;
    }
    return true;
  }

  bool isExisLabel(String name) {
    return widget.labelList.any((element) => element.name == name);
  }

  Widget getLabelWidget(int index) {
    final String name = widget.labelList[index].name;
    final Color color = Color(widget.labelList[index].color);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.labelList.length <= 1) {
            showTagRemoveWarringDialog(context);
            return;
          }
          removeTag(index);
          widget.labelList.removeAt(index);
          widget.updateList(widget.labelList);
        });
      },
      child: LabelWidget(
        name,
        color,
        icon: Icons.close,
      ),
    );
  }

  void showTagRemoveWarringDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('태그를 모두 지울순 없습니다.'),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            )
          ],
        );
      },
    );
  }

  void removeTag(int index) {
    BlocProvider.of<TagBloc>(context)
        .add(DeleteTagEvent(widget.labelList[index]));
  }

  void createTag(Tag tag) {
    BlocProvider.of<TagBloc>(context).add(CreateTagEvent(tag));
  }
}
