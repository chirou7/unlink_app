import os

files_to_dummy = [
    "lib/pages/device_detail_page.dart",
    "lib/pages/device_settings_page.dart",
    "lib/pages/device_share_page.dart",
    "lib/pages/alert_settings_page.dart",
    "lib/pages/add_device_page.dart",
    "lib/pages/device_activated_page.dart",
    "lib/pages/device_check_page.dart",
    "lib/pages/alert_page.dart",
    "lib/pages/about_page.dart",
    "lib/pages/manual_add_page.dart"
]

for file_path in files_to_dummy:
    class_name = "".join(word.title() for word in os.path.basename(file_path).replace('.dart', '').split('_'))
    content = f"""import 'package:flutter/material.dart';

class {class_name} extends StatelessWidget {{
  final dynamic device;
  const {class_name}({{super.key, this.device}});

  @override
  Widget build(BuildContext context) {{
    return const Scaffold(body: Center(child: Text('{class_name}')));
  }}
}}
"""
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)
