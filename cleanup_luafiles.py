import os
import sys


def delete_lua_files(root_dir, delete_all=False):
    for dirpath, dirnames, filenames in os.walk(root_dir, topdown=True):
        # Skip 'release' directory and its subdirectories
        dirnames[:] = [d for d in dirnames if d != 'release']

        # Optionally skip 'lib' directory and its subdirectories
        if not delete_all:
            dirnames[:] = [d for d in dirnames if d != 'lib']

        for filename in filenames:
            if filename.endswith('.lua'):
                file_path = os.path.join(dirpath, filename)
                print(f"Deleting: {file_path}")
                os.remove(file_path)


if __name__ == "__main__":
    delete_all = '--all' in sys.argv
    current_directory = os.getcwd()
    delete_lua_files(current_directory, delete_all)
    print("Deletion process completed.")
