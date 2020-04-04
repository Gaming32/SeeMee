import os
def count_files_in_dir(path):
    count = 0
    for name in os.listdir(path):
        if os.path.isfile(os.path.join(path, name)):
            count += 1
    return count

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