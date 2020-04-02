import os

cdef void download_dependencies():
    if os.path.exists(os.path.join(__file__, 'seemee-dependencies-web.txt')):
        import requests
        files = open('seemee-dependencies-web.txt').read().split('\n')[:-1]
        for file in files:
            pass

cdef int cmain(int argc, list argv):
    return 0

def main(list argv):
    return cmain(len(argv), argv)