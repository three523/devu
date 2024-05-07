import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetupAsset extends StatefulWidget {
  @override
  State<SetupAsset> createState() => _SetupAssetState();
}

class _SetupAssetState extends State<SetupAsset> {
  DateTime selectedDate = DateTime.now();
  List<String> labelList = ['예금', '장기채', '미국ETF'];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '목표',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: '어떤 목표인지 적어주세요',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            ),
          ),
          Text(
            '목표금액',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              '500만원',
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text('-목표금액+'),
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
              '2.8%',
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text('-목표 수익률+'),
          ),
          Text(
            '목표 날짜',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
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
            child: Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}'),
          ),
          Text(
            '어떤 방식으로 모을까요?',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          DropdownMenu<Text>(
            dropdownMenuEntries: [
              DropdownMenuEntry(value: Text(''), label: labelList[0]),
              DropdownMenuEntry(value: Text(''), label: labelList[1]),
              DropdownMenuEntry(value: Text(''), label: labelList[2]),
            ],
          ),
          Text(
            '메모를 작성해주세요.',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: '자산에 표시할 한줄 메모를 적어주세요',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            ),
          ),
        ],
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
}
