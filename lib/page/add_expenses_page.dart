import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum RecodeType { income, expenses }

//TODO: 키보드 올라갈때 버튼 어떻게 할지 처리하기

class AddExpenses extends StatefulWidget {
  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final isSelected = <bool>[true, false];
  List<String> labelList = ['충동구매', '예상 초과'];
  TextEditingController priceController = TextEditingController(text: '0');
  int price = 0;
  double bottomInset = 0.0;

  @override
  Widget build(BuildContext context) {
    bottomInset = MediaQuery.of(context).viewInsets.bottom;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('기록 하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleButtons(
              borderRadius: BorderRadius.circular(4.0),
              constraints: BoxConstraints(
                  minHeight: 20, minWidth: 60, maxHeight: 34, maxWidth: 60),
              children: [
                Center(child: Text('지출')),
                Center(child: Text('수입')),
              ],
              onPressed: (index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected[buttonIndex] = true;
                    } else {
                      isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              color: primaryColor,
              borderColor: primaryColor,
              selectedBorderColor: primaryColor,
              fillColor: primaryColor,
              selectedColor: Colors.white,
              isSelected: isSelected,
            ),
            SizedBox(
              height: 24,
            ),
            isExpenses()
                ? Text(
                    '얼마를 썼나요?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                : Text(
                    '얼마를 더할까요?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
            Row(
              children: [Spacer(), Text("${formatToKoreanNumber(price)}원")],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: priceController,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        price = 0;
                      } else {
                        price = value.toPrice() ?? price;
                      }
                      priceController.text = price.toPriceString();
                    });
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              '카테고리를 설정해주세요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 91, 148, 168),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {},
                      child: Text('식비'),
                    ),
                    isOutOfExpenses()
                        ? Container()
                        : Text(
                            '예산을 10,000원 초과했어요',
                            style: TextStyle(color: Colors.red),
                          ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              '라벨를 설정해주세요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            DropdownMenu<Text>(
              dropdownMenuEntries: [
                DropdownMenuEntry(value: Text(''), label: labelList[0]),
                DropdownMenuEntry(value: Text(''), label: labelList[1]),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              '메모를 작성해주세요',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                      hintText: '기록에 표시될 상세 내용을 작성해주세요.',
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomSheet: SafeArea(
        child: Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('저장하기'),
          ),
        ),
      ),
    );
  }

  bool isExpenses() {
    return isSelected[0];
  }

  bool isOutOfExpenses() {
    return true;
  }
}
