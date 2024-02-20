import 'package:business_chat/main.dart';
import 'package:business_chat/pages/contact_page.dart';
import 'package:business_chat/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode searchFocus = FocusNode();

    //searchController.clear();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 20),
                child: TextField(
                  onChanged: (value) {
                    context.read<ContactProvider>().notify();
                    lettersTyped = value.length;

                    searchList = keyList.where((element) {
                      if (lettersTyped >= 1 && element.length >= lettersTyped) {
                        return element
                                .substring(0, lettersTyped)
                                .toLowerCase() ==
                            value.substring(0, lettersTyped).toLowerCase();
                      }

                      return false;
                    }).toList();
                  },
                  controller: searchController,
                  focusNode: searchFocus,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: " Search...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Consumer<ContactProvider>(builder: (context, value, child) {
          return Expanded(
              child: (lettersTyped >= 1)
                  ? ListView.builder(
                      //counting how many matches are there between letters typed and names in database
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        String key = searchList[index];
                        return ContactWidget(
                            contact: Contact(name: key, role: m[key] ?? "N/A"));
                      },
                    )
                  : Container());
        })
      ]),
    );
  }
}
