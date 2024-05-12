import 'package:devu_app/data/model/expense_category.dart';
import 'package:devu_app/data/model/expense_category_list.dart';
import 'package:devu_app/expense_bloc.dart';
import 'package:devu_app/expense_event.dart';
import 'package:devu_app/expense_state.dart';
import 'package:devu_app/utils/extenstion.dart';
import 'package:devu_app/utils/utils.dart';
import 'package:devu_app/widget/category_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddCategoryPage extends StatefulWidget {
  DateTime categoryDateTime;

  AddCategoryPage(this.categoryDateTime);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  // List<String> categoryItemList = ['교통비', '식비', '용돈'];
  TextEditingController textEditingController = TextEditingController();
  int price = 0;

  @override
  void initState() {
    super.initState();

    print('테스트: ${widget.categoryDateTime.day}');
    BlocProvider.of<ExpenseBloc>(context)
        .add(LoadByDayExpenseEvent(widget.categoryDateTime));
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            if (state is ExpenseSucessState) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.eventModel.categoryList.length + 2,
                itemBuilder: (context, index) {
                  return getListViewItem(state.eventModel, index);
                },
              );
            } else {
              return Text('실패');
            }
          },
        ),
      ),
    );
  }

  Widget getListViewItem(ExpenseCategoryList categoryList, int index) {
    print(index);
    if (index == 0) {
      int totalBelowMoney = categoryList.categoryList.fold(
          0, (previousValue, element) => previousValue + element.belowMoeny);
      return getHeaderView(totalBelowMoney);
    } else if (index == categoryList.categoryList.length + 1) {
      return getAddCategoryButton();
    } else {
      return getCategoryCard(categoryList, index - 1);
    }
  }

  Column getHeaderView(int totalBelowMoney) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('2024.5월 총 예산'),
        Container(
          width: double.infinity,
          child: Text(
            totalBelowMoney.toPriceString(),
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  ConstrainedBox getAddCategoryButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 180, minHeight: 140),
      child: Card(
        child: GestureDetector(
          onTap: showAddCategoryDialog,
          child: DottedBorder(
            strokeWidth: 1,
            borderType: BorderType.RRect,
            radius: Radius.circular(16),
            strokeCap: StrokeCap.square,
            dashPattern: [4],
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(size: 60.0, Icons.add),
                  Text('카테고리 추가하기'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAddCategoryDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: Text('카테고리를 만들어주세요'),
            content: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(hintText: '카테고리 이름을 입력해주세요'),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (textEditingController.text.isEmpty == false) {
                      final title = textEditingController.text;
                      final state = BlocProvider.of<ExpenseBloc>(context).state;
                      print(state);
                      if (state is ExpenseSucessState &&
                          !state.eventModel.categoryList
                              .any((element) => element.title == title)) {
                        BlocProvider.of<ExpenseBloc>(context).add(
                          CreateCategoryEvent(
                            widget.categoryDateTime,
                            ExpenseCategory(
                              Uuid().v4(),
                              textEditingController.text,
                              0,
                              dateTimeToUnixTimestamp(DateTime.now()),
                              [],
                              'test',
                              [],
                            ),
                          ),
                        );
                      } else {
                        //TODO: 타이틀이 같을 경우 에러 처리
                        print('같은 타이틀');
                      }
                      Navigator.pop(context);
                    } else {
                      print('카테고리를 입력해주어야합니다.');
                    }
                  },
                  child: Text('확인')),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text('취소')),
            ],
          );
        });
  }

  Widget getCategoryCard(ExpenseCategoryList categoryList, int index) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200, minHeight: 140),
            child: CategoryCard(
              0,
              cardType: CardType.input,
              category: categoryList.categoryList[index],
              updatePrice: updatePrice,
            ),
          ),
        ),
        SizedBox(
          width: 30.0,
          height: 30.0,
          child: IconButton.outlined(
            padding: EdgeInsets.all(0.0),
            onPressed: () {
              removeCategory(categoryList.categoryList[index]);
              textEditingController.text = "";
            },
            color: Colors.black,
            icon: Icon(Icons.close),
          ),
        ),
      ],
    );
  }

  // Widget categoryColor(int index, Function setState) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //     child: GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           isSelectedColor = categoryColorList[index];
  //         });
  //       },
  //       child: Container(
  //         width: 30,
  //         height: 30,
  //         decoration: BoxDecoration(
  //           border: isSelectedColor == categoryColorList[index]
  //               ? Border.all(
  //                   color: Colors.black,
  //                   width: 1,
  //                 )
  //               : null,
  //           borderRadius: BorderRadius.circular(15),
  //           color: categoryColorList[index],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void updatePrice(ExpenseCategory? category, int addPrice) {
    setState(() {
      if (category != null) {
        category.belowMoeny += addPrice;
        BlocProvider.of<ExpenseBloc>(context)
            .add(UpdateCategoryEvent(category));
      }
    });
  }

  void removeCategory(ExpenseCategory category) {
    BlocProvider.of<ExpenseBloc>(context)
        .add(DeleteCategoryEvent(widget.categoryDateTime, category));
  }
}
