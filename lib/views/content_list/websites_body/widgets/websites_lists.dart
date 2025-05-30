import 'package:flutter/material.dart';
import 'package:ia_web_front/views/content_list/controller/websites_controller.dart';
import 'package:ia_web_front/views/content_list/websites_body/widgets/website_item.dart';

class WebsitesList extends StatelessWidget {
  final WebsiteController controller;

  const WebsitesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTableHeader(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: controller.websites.length,
          itemBuilder: (context, index) {
            final website = controller.websites[index];
            return WebsiteListItem(
              website: website,
              index: index,
              controller: controller,
            );
          },
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Website', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Last Checked', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(),
        ],
      ),
    );
  }
}
