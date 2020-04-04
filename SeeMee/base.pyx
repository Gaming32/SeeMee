from __future__ import print_function

import sys, os

from .arguments import argument_parser

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
    # print('args:', args)

    cdef list cameras_pre, cameras
    cameras_pre = pygame.camera.list_cameras()
    cameras = []
    for camera in cameras_pre:
        if camera not in args.ignore_cameras:
            cameras.append(camera)
    cameras.extend(args.include_cameras)
    del cameras_pre

    if not cameras:
        print('no cameras found')
        return 1

    print('cameras:', ', '.join(str(x) for x in cameras))
    for (i, camera) in enumerate(cameras):
        print('initializing camera', camera)
        cameras[i] = (camera, pygame.camera.Camera(camera))
        cameras[i][1].start()
        print('initialized camera', camera)
    print('camera names:', ', '.join(x[1].dev.getdisplayname() for x in cameras))

    cdef int camera_ix, camera_count
    cdef double time_passed, time_passed_seconds, time_since_check
    cdef tuple resolution
    if args.resolution is not None:
        resolution = tuple(args.resolution)
    else:
        resolution = cameras[0][1].get_image().get_size()
    window = pygame.display.set_mode(resolution)
    camera_ix = 0
    camera_count = len(cameras)
    time_since_check = 0
    clock = pygame.time.Clock()
    while True:
        time_passed = clock.tick(args.framerate)
        time_passed_seconds = time_passed / 1000
        time_since_check += time_passed_seconds
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                print('stopping')
                for camera in cameras:
                    print('deinitializing camera', camera[0])
                    camera[1].stop()
                    print('deinitialized camera', camera[0])
                print('deinitializing pygame')
                pygame.quit()
                print('deinitialized pygame')
                return 0
        if time_since_check >= args.check_time:
            time_since_check = 0
            camera_ix = (camera_ix + 1) % camera_count
            print('switched to camera', cameras[camera_ix][0], '(%s)' % cameras[camera_ix][1].dev.getdisplayname())
        frame = pygame.transform.scale(cameras[camera_ix][1].get_image(), resolution)
        window.blit(frame, (0, 0))
        pygame.display.update()

    return 1


cdef int cmain(int argc, list argv):
    args = argument_parser.parse_args()
    return run(args)

def main(list argv=sys.argv):
    return cmain(len(argv), argv)


__all__ = ['main']