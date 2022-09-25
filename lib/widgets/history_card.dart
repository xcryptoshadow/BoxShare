// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_cast, must_be_immutable, curly_braces_in_flow_control_structures, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:giga_share/models/user_model.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryCard extends StatefulWidget {
  List<UserModel>? transactions;
  HistoryCard({Key? key, this.transactions}) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  UserModel transaction = UserModel();

  void _launchURL(url) async {
    if (!await launch(url))
      throw 'Could not launch ${url}';
  }

  @override
  Widget build(BuildContext context) {
    return (widget.transactions!.isEmpty)
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.23),
            child: Center(
              child: Text(
                'No transaction history',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.transactions!.length,
            itemBuilder: (BuildContext context, int index) {
              final history = widget.transactions![index];
              return buildCard(history);
            },
          );
  }

  buildCard(UserModel history) {
    return InkWell(
      onTap: () => _launchURL(history.url),
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          height: 60,
          child: Row(
            children: [
              SizedBox(width: 5),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.appColor,
                ),
                child: Center(
                  child: Icon(
                    (history.received == false) ? Icons.upload_file_rounded : Icons.file_download,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.63),
                    child: Text(
                      history.url,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.appColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      history.date,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black87,
                size: 12,
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
