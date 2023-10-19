import 'package:flutter/material.dart';
import 'package:newsapp/models/modellprovider.dart';
import 'package:newsapp/resource/sourcd.dart';
import 'package:provider/provider.dart';

class PopUpDialog extends StatelessWidget {
  const PopUpDialog({super.key, this.countrypop = true});
  final bool countrypop;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      // backgroundColor: Colors.transparent.withOpacity(0.8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.07,
            width: width * 0.6,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 215, 198, 147),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Countries",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: width * 0.6,
            height: height * 0.45,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: country.length,
              itemBuilder: (context, index) {
                return Listviewer(
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class Listviewer extends StatefulWidget {
  final int index;

  const Listviewer({
    super.key,
    required this.index,
  });

  @override
  State<Listviewer> createState() => _ListviewerState();
}

class _ListviewerState extends State<Listviewer> {
  final TextStyle normalTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  final TextStyle selectedTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    final listdata = Provider.of<ModelProvider>(context);
    return GestureDetector(
      onTap: () async {
        setState(() {
          listdata.loading = true;
        });
        await listdata.getdatta(widget.index);
        setState(() {
          listdata.loading = false;
        });
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.only(bottom: 5, right: 10),
        decoration: BoxDecoration(
          color: (listdata.index == widget.index)
              ? Colors.red.shade50
              : Colors.transparent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          country[widget.index],
          textAlign: TextAlign.center,
          style: (listdata.index == widget.index)
              ? selectedTextStyle
              : normalTextStyle,
        ),
      ),
    );
  }
}
