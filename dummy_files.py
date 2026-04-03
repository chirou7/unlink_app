import os

files_to_dummy = [
    "lib/pages/email_page.dart",
    "lib/pages/find_pet_page.dart",
    "lib/pages/firmware_upgrade_page.dart",
    "lib/pages/health_page.dart",
    "lib/pages/help_feedback_page.dart",
    "lib/pages/help_page.dart",
    "lib/pages/language_page.dart",
    "lib/pages/light_settings_page.dart",
    "lib/pages/manual_add_page.dart",
    "lib/pages/orders_page.dart",
    "lib/pages/pet_detail_page.dart"
]

for file_path in files_to_dummy:
    class_name = "".join(word.title() for word in os.path.basename(file_path).replace('.dart', '').split('_'))
    content = f"""import 'package:flutter/material.dart';

class {class_name} extends StatelessWidget {{
  final dynamic mode;
  final dynamic device;
  const {class_name}({{super.key, this.mode, this.device}});

  @override
  Widget build(BuildContext context) {{
    return const Scaffold(body: Center(child: Text('{class_name}')));
  }}
}}
"""
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(content)
