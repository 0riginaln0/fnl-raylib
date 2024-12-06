import os

def delete_lua_files(root_dir):
    for dirpath, dirnames, filenames in os.walk(root_dir):
        # Check if the current directory is "lib" or "release"
        if 'lib' in dirpath.split(os.sep) or 'release' in dirpath.split(os.sep):
            continue
        
        for filename in filenames:
            if filename.endswith('.lua'):
                file_path = os.path.join(dirpath, filename)
                print(f'Deleting: {file_path}')  # Print the file being deleted
                os.remove(file_path)

if __name__ == "__main__":
    current_directory = os.getcwd()  # Get the current working directory
    delete_lua_files(current_directory)