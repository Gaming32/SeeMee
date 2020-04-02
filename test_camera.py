RESOLUTION = (640, 480)
FULLSCREEN = False
CAMERA = 1


import pygame
import pygame.camera
print(pygame.init())
pygame.camera.init()

if CAMERA is None:
    cam_name = pygame.camera.list_cameras()[0]
else: cam_name = CAMERA

cam = pygame.camera.Camera(cam_name)
cam.start()

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