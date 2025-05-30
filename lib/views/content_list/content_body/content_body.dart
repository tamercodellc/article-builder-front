import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/views/content_list/Content_Body/content_body_topicclusters.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body_gaps.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body_list.dart';
import 'package:ia_web_front/views/content_list/content_body/content_body_performance.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/inside_card.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/tab_bar_section.dart';
import 'package:ia_web_front/views/content_list/content_body/widgets/website_dropdown.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:provider/provider.dart';

class ContentBodyState extends StatefulWidget {
  const ContentBodyState({super.key});

  @override
  State<ContentBodyState> createState() => __ContentBodyStateState();
}

class __ContentBodyStateState extends State<ContentBodyState> {
  int selectedTab = 0;
  ContentCardModel? selectedContentCard;

  @override
  Widget build(BuildContext context) {
    return Consumer<WebsiteController>(
        builder: (context, websiteController, child) {
      final websites = websiteController.websites
          .map((website) => {
                'name': website.name,
                'url': website.url,
              })
          .toList();

      return Padding(
        padding: EdgeInsets.all(24.0),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Content',
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold)),
                      Row(children: [
                        Text('Selected Website:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 92, 92, 92))),
                        SizedBox(width: 8),
                        WebsiteDropdown(
                          websites: websites,
                          onAddWebsite: () {
                            // Lógica para añadir un nuevo website
                          },
                        ),
                      ]), // opciones para selecccionar website
                    ]),
                SizedBox(height: 16),
                TabBarSection(
                    selectedIndex: selectedTab,
                    onTabSelected: (index) => setState(() {
                          selectedTab = index;
                        })),
                SizedBox(height: 16),
                IndexedStack(
                  index: selectedTab,
                  children: [
                    selectedTab == 0 && selectedContentCard != null
                        ? InsideCard(
                            contentCards: websiteController
                                    .selectedWebsite?.contentCards ??
                                [],
                            backOnPressed: () => setState(
                                  () {
                                    selectedContentCard = null;
                                  },
                                ))
                        : ContentCardsList(
                            onPressed: (contentCard) {
                              setState(() {
                                selectedContentCard = contentCard;
                                websiteController
                                    .selectContentCard(contentCard);
                              });
                            },
                          ),
                    Performance(),
                    TopicClusters(),
                    ContentGaps(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
