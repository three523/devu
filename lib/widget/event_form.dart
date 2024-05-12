// import 'package:devu_app/data/model/money.dart';
// import 'package:devu_app/utils/extenstion.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:uuid/uuid.dart';

// class EventForm extends StatefulWidget {
//   final void Function(Money)? onEventAdd;
//   final void Function()? onEventDelete;

//   final Money? event;
//   final DateTime date;

//   final List<String> labels;
//   final List<String> categorys;

//   const EventForm({
//     super.key,
//     this.onEventAdd,
//     this.onEventDelete,
//     this.event,
//     required this.labels,
//     required this.categorys,
//     required this.date,
//   });

//   @override
//   State<EventForm> createState() => _EventFormState();
// }

// class _EventFormState extends State<EventForm> {
//   late DateTime eventDate =
//       widget.event == null ? widget.date : widget.event!.date.withoutTime;

//   final form = GlobalKey<FormState>();

//   late final titleController = TextEditingController(
//       text: widget.event == null ? '0' : widget.event?.price.toString());
//   late final titleNote = FocusNode();
//   late final descriptionNode = FocusNode();

//   String previousValue = '0';
//   String currntValue = '0';

//   List<bool> isSelectedButtons = [false, false];
//   late String selectedCategory =
//       widget.event == null ? '취미/여가' : widget.event!.eventCategory;
//   List<Color> categoryColors = [
//     Colors.orangeAccent,
//     Colors.greenAccent,
//     Colors.blueAccent,
//     Colors.redAccent
//   ];

//   List<String> selectedLabels = [];

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: form,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextFormField(
//             controller: titleController,
//             decoration: InputDecoration(
//               hintText: '비용',
//             ),
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//             onChanged: (value) {
//               var maxLength = 19;
//               if (value == '') {
//                 titleController.text = '0';
//                 currntValue = '0';
//                 previousValue = '0';
//                 return;
//               }
//               if (value.length > maxLength) {
//                 titleController.text = previousValue;
//                 return;
//               }

//               previousValue = currntValue;
//               currntValue = value.toPriceString();

//               titleController.text = currntValue;
//             },
//             validator: (value) {
//               if (value == null || value == '' || value == '0') {
//                 return '비용을 입력해주세요';
//               }
//               return null;
//             },
//             keyboardType: TextInputType.number,
//           ),
//           // SizedBox(height: 15.0),
//           // DateTimeSelectorFormField(
//           //   decoration: InputDecoration(hintText: 'Date'),
//           //   initialDateTime: eventDate,
//           //   onSelect: (date) {
//           //     eventDate = date.withoutTime;
//           //   },
//           //   validator: (value) {
//           //     if (value == null || value == '') {
//           //       return '날짜를 선택해주세요';
//           //     }
//           //     return null;
//           //   },
//           //   onSave: (date) => eventDate = date ?? eventDate,
//           //   type: DateTimeSelectionType.date,
//           // ),
//           SizedBox(height: 15.0),
//           Text('카테고리'),
//           GridView.builder(
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 5, mainAxisSpacing: 5.0, crossAxisSpacing: 5.0),
//             itemCount: widget.categorys.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 child: TextButton(
//                   child: Text(widget.categorys[index]),
//                   onPressed: () {
//                     selectedCategory = widget.categorys[index];
//                   },
//                 ),
//                 color: categoryColors[index],
//               );
//             },
//           ),
//           Text('라벨'),
//           GridView.builder(
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 5, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
//             itemCount: widget.labels.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 child: TextButton(
//                   child: Text(widget.labels[index]),
//                   onPressed: () {
//                     if (selectedLabels.contains(widget.labels[index])) {
//                       selectedLabels.remove(widget.labels[index]);
//                     } else {
//                       selectedLabels.add(widget.labels[index]);
//                     }
//                   },
//                 ),
//                 color: Colors.blueGrey,
//               );
//             },
//           ),
//           Row(
//             children: [
//               if (widget.event != null)
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: removeEvent,
//                     child: Text('삭제하기'),
//                   ),
//                 ),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: createEvent,
//                   child: Text(widget.event == null ? '추가하기' : '업데이트'),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void createEvent() {
//     if (form.currentState?.validate() == false) {
//       return form.currentState?.save();
//     }

//     final event = Money(
//         id: widget.event == null ? const Uuid().v4() : widget.event!.id,
//         price: titleController.text.trim().toPrice() ?? 0,
//         date: eventDate,
//         eventCategory: selectedCategory,
//         labels: selectedLabels,
//         type: '');
//     widget.onEventAdd?.call(event);
//   }

//   void removeEvent() {
//     widget.onEventDelete?.call();
//   }
// }
