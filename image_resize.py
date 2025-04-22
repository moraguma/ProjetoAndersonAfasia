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


