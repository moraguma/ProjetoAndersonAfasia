# Jogo de Afasia por um Afásico
# Copyright (C) 2025 Gustavo Araújo Morais
# 
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

from PIL import Image
import os


def resize_image(im: Image):
    width, height = im.size

    if width >= height:
        im = im.resize((int(300 * width / height), 300))
    else:
        im = im.resize((300, int(300 * height / width)))

    return im


image_paths = []
for root, dirs, files in os.walk("resources\images\levels"):
    if not root.endswith("changes"):
        continue
    for file in files:
        if file.endswith(".png") or file.endswith(".jpg") or file.endswith(".jpeg"):
            image_paths.append(os.path.join(root, file))


for path in image_paths:
    try:
        image = Image.open(path)
        image = resize_image(image)
        image.save(path)
    except:
        print(f"Error on {path}")


