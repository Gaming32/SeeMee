RESOLUTION = (640, 480)
FULLSCREEN = False
CAMERA = 1


import pygame
import pygame.camera
print(pygame.init())
pygame.camera.init()

camera_list = pygame.camera.list_cameras()
print('cameras:', ', '.join(str(x) for x in camera_list))
if CAMERA is None:
    cam_name = camera_list[0]
else: cam_name = CAMERA

print('camera id:', cam_name)
cam = pygame.camera.Camera(cam_name)
cam.start()
print('camera name:', cam.dev.getdisplayname())

if FULLSCREEN:
    FULLSCREEN = pygame.FULLSCREEN
else: FULLSCREEN = 0

win = pygame.display.set_mode(RESOLUTION, FULLSCREEN)

while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            cam.stop()
            pygame.quit()
            exit()
    win.blit(pygame.transform.scale(cam.get_image(), RESOLUTION), (0, 0))
    pygame.display.update()