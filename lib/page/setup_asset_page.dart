import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/label_selector_widget.dart';
import 'package:devu_app/widget/number_update_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SetupAssetPage extends StatefulWidget {
  @override
  State<SetupAssetPage> createState() => _SetupAssetPageState();
}

class _SetupAssetPageState extends State<SetupAssetPage> {
  DateTime selectedDate = DateTime.now();
  int goalMoeny = 0;
  double goalRateOfReturn = 0.0;
  List<String> labelList = ['예금', '장기채', '미국ETF'];
  DateTime seletedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('지출 예산 설정하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '목표',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '어떤 목표인지 적어주세요',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8.0),
                  isDense: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                '목표금액',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                formatToKoreanNumber(goalMoeny),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: NumberUpdateWidget(
                10000,
                (updateGoalMoney) {
                  setState(
                    () {
                      goalMoeny = updateGoalMoney.toInt();
                    },
                  );
                },
                valueType: ValueType.money,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '목표 수익률',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                '${goalRateOfReturn.toString()}%',
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: NumberUpdateWidget(
                0.1,
                (updateRateOfReturn) {
                  setState(
                    () {
                      goalRateOfReturn = updateRateOfReturn.toDouble();
                    },
                  );
                },
                valueType: ValueType.number,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '목표 날짜',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(DateTime.now().year + 49, 12, 31),
                );
                if (selectedDate != null) {
                  setState(() {
                    this.selectedDate = selectedDate;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                            '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '어떤 방식으로 모을까요?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            LabelSelectorWidget(
              onSelecteds: (p0) {},
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '메모를 작성해주세요.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '화면에 표시할 메모 한줄을 작성해주세요.',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(8.0),
                isDense: true,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              '저장하기',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
