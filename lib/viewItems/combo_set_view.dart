import 'package:flutter/material.dart';
import 'package:movies_booking/resources/dimen.dart';
import 'package:movies_booking/resources/strings.dart';
import 'package:movies_booking/widgets/normal_text_view.dart';
import 'package:movies_booking/widgets/title_and_description_view.dart';
import 'package:movies_booking/widgets/title_text.dart';

import '../data/vos/snack_vo.dart';

class ComboSetView extends StatelessWidget {
  final SnackVO? snackVO;
  // final Function(int quantity, String action) onTapCount;
  final VoidCallback onTapIncrease;
  final VoidCallback onTapDecrease;
  ComboSetView(
      {required this.snackVO,
      required this.onTapIncrease,
      required this.onTapDecrease});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TitleAndDescriptionView(
              snackVO?.name ?? "",
              snackVO?.description ?? "",
            ),
          ),
          Spacer(),
          ComboPricerAndNumbersView(
            snackVO: snackVO,
            onTapDecrease: onTapDecrease,
            onTapIncrease: onTapIncrease,
          ),
        ],
      ),
    );
  }
}

class ComboPricerAndNumbersView extends StatelessWidget {
  final SnackVO? snackVO;
  //final Function(int quantity,String action) onTapCount;
  final VoidCallback onTapIncrease;
  final VoidCallback onTapDecrease;
  ComboPricerAndNumbersView(
      {required this.snackVO,
      required this.onTapIncrease,
      required this.onTapDecrease});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText("${snackVO?.price ?? 0}\$"),
        SizedBox(
          height: 4,
        ),
        NumberPickerView(
          snackVO: snackVO,
          onTapDecrease: onTapDecrease,
          onTapIncrease: onTapIncrease,
        )
      ],
    );
  }
}

class NumberPickerView extends StatelessWidget {
  //final Function(int quantity,String action) onTapCount;
  final VoidCallback onTapIncrease;
  final VoidCallback onTapDecrease;
  final SnackVO? snackVO;
  NumberPickerView(
      {required this.snackVO,
      required this.onTapIncrease,
      required this.onTapDecrease});
  @override
  Widget build(BuildContext context) {
    int count = snackVO?.quantity ?? 0;
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26)),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              // onTapCount(--count,ACTION_DECREASE);
              onTapDecrease();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: MARGIN_SMALL_2, right: MARGIN_CARD_SMALL),
              child: Icon(
                Icons.remove,
                size: 18,
              ),
            ),
          ),
          VerticalDivider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
            child: NormalTextView(
              "${snackVO?.quantity ?? 0}",
              textColor: Colors.black26,
            ),
          ),
          VerticalDivider(
            thickness: 1,
          ),
          InkWell(
            onTap: () => onTapIncrease(),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: MARGIN_CARD_SMALL, right: MARGIN_SMALL_2),
              child: Icon(
                Icons.add,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
