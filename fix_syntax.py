import os
import re

def fix_syntax_mojibake():
    # Read the corrupted UTF-8 string
    for root, dirs, files in os.walk("lib"):
        for file in files:
            if not file.endswith(".dart"):
                continue
            path = os.path.join(root, file)
            
            with open(path, "r", encoding="utf-8") as f:
                content = f.read()
            
            changed = False
            
            # Replace �?, with �?',
            new_content = re.sub(r'�\?,', r"�?',", content)
            if new_content != content: changed = True; content = new_content
            
            # Replace �?] with �?']
            new_content = re.sub(r'�\?]', r"�?']", content)
            if new_content != content: changed = True; content = new_content
            
            # Replace �?) with �?')
            new_content = re.sub(r'�\?\)', r"�?')", content)
            if new_content != content: changed = True; content = new_content
            
            # Replace �?; with �?';
            new_content = re.sub(r'�\?;', r"�?';", content)
            if new_content != content: changed = True; content = new_content
            
            # Replace �?: with �?':
            new_content = re.sub(r'�\?:', r"�?':", content)
            if new_content != content: changed = True; content = new_content

            # Replace �?\n with �?'\n (if it was an open string, assuming end of line)
            # We'll be careful here to only do it if the line has an odd number of quotes
            # Actually, let's just do it for common patterns like assignment
            new_content = re.sub(r"=\s*'([^'\n]*?)�\?\n", r"= '\1�?';\n", content)
            if new_content != content: changed = True; content = new_content

            if changed:
                with open(path, "w", encoding="utf-8") as f:
                    f.write(content)
                print(f"Fixed syntax in {path}")

if __name__ == "__main__":
    fix_syntax_mojibake()
