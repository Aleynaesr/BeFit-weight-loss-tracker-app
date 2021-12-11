import 'package:weight_loss_tracker/model/view_type.dart';

import 'item.dart';

class Header implements Item {
  final String date;
  Header({this.date});

  @override
  ViewType getViewType() {
    return ViewType.HEADER;
  }
}
