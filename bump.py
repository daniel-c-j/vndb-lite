import re
import argparse
import subprocess
import json

def update_version(file_path, version):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for line in lines:
            if line.startswith('version:'):
                file.write(f'version: {version}+1\n')
            else:
                file.write(line)

def update_version_json(file_path, version):
    with open(file_path, 'r') as file:
        data = json.load(file)

    data['latestV'] = version

    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

def commit_and_create_git_tag(version):
    try:
        subprocess.run(['git', 'commit', '-a', '-m', 'Bump Version'], check=True)
        subprocess.run(['git', 'tag', '-a', version, '-m', f'*** See changelog for [{version}] ***'], check=True)
        print(f'Git tag {version} created successfully')
    except subprocess.CalledProcessError as e:
        print(f'Failed to create Git tag {version}: {e}')

def main():
    parser = argparse.ArgumentParser(description='Update version in files and create Git tag')
    parser.add_argument('-v', help='New version', required=True)
    args = parser.parse_args()

    version_arg = args.v.replace("v", "", 1)
    update_version('pubspec.yaml', version_arg)
    update_version_json('VERSION.json',version_arg)

    commit_and_create_git_tag(args.v)

if __name__ == '__main__':
    main()
