from __future__ import print_function

import sys, os
import argparse

from .info import __version__

sys.stdout = open(os.devnull, 'w')
import pygame
import pygame.camera
sys.stdout = sys.__stdout__


cdef int run(args):
    cdef int i
    print('initializing pygame')
    pygame.init()
    pygame.camera.init()
    print('pygame initialized')
    print('args:', args)

    cdef list cameras_pre, cameras
    cameras_pre = pygame.camera.list_cameras()
    cameras = []
    for camera in cameras_pre:
        if camera not in args.ignore_cameras:
            cameras.append(camera)
    cameras.extend(args.include_cameras)
    del cameras_pre

    print('cameras:', ', '.join(str(x) for x in cameras))
    for (i, camera) in enumerate(cameras):
        print('initializing camera', camera)
        cameras[i] = pygame.camera.Camera(camera)
        cameras[i].start()
        print('initialized camera', camera)
    print('camera names:', ', '.join(x.dev.getdisplayname() for x in cameras))

    return 0


argument_parser = argparse.ArgumentParser()
argument_parser.add_argument('-V', '--version', action='version', version='SeeMee '+__version__)
argument_parser.add_argument('-i', '--ignore-camera', dest='ignore_cameras', metavar='ID', type=int, action='append', default=[])
argument_parser.add_argument('-c', '--include-camera', dest='include_cameras', metavar='ID', type=int, action='append', default=[])

cdef int cmain(int argc, list argv):
    args = argument_parser.parse_args()
    return run(args)

def main(list argv):
    return cmain(len(argv), argv)


__all__ = ['main', 'argument_parser']