import os
import glob

def reverse_mojibake():
    # Read the corrupted UTF-8 string
    for root, dirs, files in os.walk("lib"):
        for file in files:
            if file.endswith(".dart"):
                path = os.path.join(root, file)
                
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
                
                # Check if it has mojibake (like 锟?, 鍐呭, 鏉℃, etc)
                # We can just encode the UTF-8 string back to GBK bytes!
                try:
                    # If the content was previously read as GBK and saved as UTF-8,
                    # encoding it back to GBK will yield the original UTF-8 bytes!
                    original_bytes = content.encode('gbk', errors='replace')
                    
                    # Now decode the original bytes as UTF-8
                    fixed_content = original_bytes.decode('utf-8', errors='replace')
                    
                    if fixed_content != content:
                        with open(path, "w", encoding="utf-8") as f:
                            f.write(fixed_content)
                        print(f"Fixed {path}")
                except Exception as e:
                    print(f"Skipped {path}: {e}")

if __name__ == "__main__":
    reverse_mojibake()
