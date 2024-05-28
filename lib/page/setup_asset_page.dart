import 'package:devu_app/asset_bloc.dart';
import 'package:devu_app/asset_event.dart';
import 'package:devu_app/data/model/asset.dart';
import 'package:devu_app/data/model/tag.dart';
import 'package:devu_app/data/resource.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/label_selector_widget.dart';
import 'package:devu_app/widget/number_update_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class SetupAssetPage extends StatefulWidget {
  Asset? asset;

  SetupAssetPage({this.asset});
  @override
  State<SetupAssetPage> createState() => _SetupAssetPageState();
}

class _SetupAssetPageState extends State<SetupAssetPage> {
  late TextEditingController titleController =
      TextEditingController(text: widget.asset?.title ?? '');
  late TextEditingController memoController =
      TextEditingController(text: widget.asset?.memo ?? '');
  late DateTime goalDate = widget.asset != null
      ? unixTimestampToDateTime(widget.asset!.goalTimestamp)
      : DateTime.now().add(Duration(days: 1));
  late int goalMoney = widget.asset?.goalMoney ?? 0;
  late double goalRateOfReturn = widget.asset?.goalRate ?? 0.0;
  late List<Tag> tagList = widget.asset?.tagList ?? [];

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
                controller: titleController,
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
                formatToKoreanNumber(goalMoney),
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
                      goalMoney = updateGoalMoney.toInt();
                    },
                  );
                },
                valueType: ValueType.money,
                initValue: goalMoney,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '연간 목표 수익률',
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
                initValue: goalRateOfReturn,
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
                  firstDate: DateTime.now().add(Duration(days: 1)),
                  lastDate: DateTime(DateTime.now().year + 49, 12, 31),
                );
                if (selectedDate != null) {
                  setState(() {
                    goalDate = selectedDate;
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
                            '${goalDate.year}.${goalDate.month}.${goalDate.day}'),
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
              selectedList: tagList,
              onSelecteds: (newTagList) {
                tagList = newTagList;
              },
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
              controller: memoController,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              isCompoundCalculate()
                  ? Container(
                      color: secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '매일 ${everyDayIncome()}원씩 모으면 가능한 계획이에요',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                onPressed: () {
                  if (validate()) {
                    if (widget.asset == null) {
                      print('creating...');
                      BlocProvider.of<AssetBloc>(context)
                          .add(CreateAssetEvent(createAsset()));
                    } else {
                      print('updating...');
                      BlocProvider.of<AssetBloc>(context)
                          .add(UpdateAssetEvent(updateAsset()));
                    }
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text(
                  '저장하기',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    String title = titleController.text;
    if (title.isEmpty && title.replaceAll(' ', '').isEmpty) {
      //TODO: title 작성이 필요하다는 경고 표시
      return false;
    } else if (goalMoney <= 0) {
      //TODO: 목표 금액 설정이 필요하다는 경고 표시
      return false;
    }
    return true;
  }

  Asset createAsset() {
    return Asset(
        Uuid().v4(),
        titleController.text,
        dateTimeToUnixTimestamp(DateTime.now()),
        dateTimeToUnixTimestamp(DateTime.now()),
        dateTimeToUnixTimestamp(goalDate),
        goalMoney,
        goalRateOfReturn,
        [],
        memoController.text,
        tagList);
  }

  Asset updateAsset() {
    final asset = widget.asset!;
    return Asset(
        asset.id,
        titleController.text,
        asset.startTimeStamp,
        dateTimeToUnixTimestamp(DateTime.now()),
        dateTimeToUnixTimestamp(goalDate),
        goalMoney,
        goalRateOfReturn,
        asset.incomeList,
        memoController.text,
        tagList);
  }

  String everyDayIncome() {
    final everyDayIncome = compoundInterest();
    final stringEveryDayIncome = formatToKoreanNumber(everyDayIncome);
    return stringEveryDayIncome;
  }

  //TODO: 복리 계산 제대로 알아보기
  int compoundInterest() {
    int betweenDays = goalDate.getDayDifference(DateTime.now());
    num rateOfReturn = goalRateOfReturn > 0.0
        ? pow((1.0 + goalRateOfReturn), betweenDays)
        : betweenDays;

    final everydayIncome = goalMoney / rateOfReturn;
    return everydayIncome.ceil();
  }

  bool isCompoundCalculate() {
    return goalMoney != 0;
  }
}
