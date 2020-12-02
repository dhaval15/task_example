import 'package:flutter/material.dart';
import 'package:extras/extras.dart';
import 'package:task/src/api/api.dart';
import 'package:task/src/models/models.dart';

class ItemView extends StatelessWidget {
  final Item item;

  const ItemView({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<String>(
            future: CartApi().getImage(item),
            builder: (context, snapshot) => snapshot.hasData
                ? Image.network(
                    snapshot.data,
                    fit: BoxFit.cover,
                  )
                : CircularProgressIndicator().center(),
          ),
          if (item.count > 1)
            Container(
              width: 32,
              height: 32,
              child: Text('${item.count}').textColor(Colors.white).center(),
              decoration: BoxDecoration(
                color: context.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x44000000),
                    blurRadius: 12,
                    spreadRadius: 4,
                    offset: Offset(2, 2),
                  )
                ],
              ),
            ).bottomRight().padding(all: 8),
        ],
      )
          .restrict(width: 200, height: 304)
          .clipRound(BorderRadius.circular(12))
          .padding(all: 12),
    );
  }
}
