import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_8ball/_support/firestore/__.dart';
import 'package:smart_8ball/_widgets/common/__.dart';

import '../logic/tries_available_cubit.dart';

class BallTries extends StatelessWidget {
  const BallTries({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TriesAvailableCubit,
        DocumentSnapshot<TriesAvailableModel>?>(
      builder: (context, state) {
        TriesAvailableModel tam = state?.data() ??
            TriesAvailableModel(TriesAvailableResourcesModel(-1));

        return ClipRRect(
          borderRadius: BorderRadius.circular(48.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: CupertinoColors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(48.0)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text('${tam.resources.basicTries} tries',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: CupertinoColors.white.withOpacity(.8),
                          fontSize: 22,
                        )),
                  ),
                  const SizedBox(width: 8),
                  const RoundedCButton(
                    padding: EdgeInsets.all(0),
                    minSize: 28,
                    filled: true,
                    child: Icon(CupertinoIcons.add, size: 24),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
