import os
import requests

def count_files_in_dir(path):
    count = 0
    for name in os.listdir(path):
        if os.path.isfile(os.path.join(path, name)):
            count += 1
    return count

api_url = 'https://www.googleapis.com/customsearch/v1'
api_base_payload = dict(
    q = '',
    num = 10,
    start = 1,
    imgSize = 'medium',
    searchType = 'image',
    key = '',
    cx = '',
)

def load_api_key(file=os.path.join(os.path.dirname(__file__), 'train_api_key')):
    for (linenum, line) in enumerate(open(file)):
        if linenum == 0:
            api_base_payload['key'] = line.rstrip()
        elif linenum == 1:
            api_base_payload['cx'] = line.rstrip()
        else: break

def main():
    if not os.path.exists('train_images'):
        os.mkdir('train_images')
        os.mkdir('train_images/looking_forward')
        os.mkdir('train_images/looking_away')
        os.mkdir('train_images/other')
        os.mkdir('train_images/other/rooms')
        os.mkdir('train_images/other/other')
    while count_files_in_dir('train_images/looking_forward') < 4200: # Download images of people looking at the camera
        pass
    while count_files_in_dir('train_images/looking_away') < 4200: # Download images of people not looking at the camera
        pass
    while count_files_in_dir('train_images/other/rooms') < 2100: # Download images of other stuff
        pass
    while count_files_in_dir('train_images/other/other') < 2100: # Download images of other stuff
        pass

if __name__ == '__main__': main()