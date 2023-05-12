import csv
import os

root = ".."
# Current dataset format to Yolo Format
# (image_name, image_width, image_height, top_x, top_y,bottom_x, bottom_y) to (class_id, x_centre,  y_centre,  width,  height) 

def execute():
    with open("indian_eu_br_us.csv", newline="") as csvfile:
        labelFile = csv.reader(csvfile, delimiter=" ", quotechar="|")
        line = 0
        for row in labelFile:
            if line > 0:
                newPath = "/datasets/custom/images/plates/"
                path = "/datasets/Indian_eu_br_us_plates_compressed/"
                labelsPath = "/datasets/custom/labels/plates/"
                columns = row[0].split(",")
                filename = columns[0]
                extension = ".jpeg"
                currentFile = f"{root}{path}{filename}{extension}"
                newFileName = str(line).zfill(12)
                newFile = f"{root}{newPath}{newFileName}{extension}"
                [image_width, image_height, top_x, top_y, bottom_x, bottom_y] = list(
                    map(lambda x: float(x), columns[1:])
                )
                x_centre = ((bottom_x - top_x) / 2) + top_x
                width = bottom_x - top_x
                y_centre = ((bottom_y - top_y) / 2) + top_y
                height = bottom_y - top_y

                yoloFormList = [x_centre, y_centre, width, height]
                values = " ".join(list(map(lambda x: "{:.6f}".format(x), yoloFormList)))
                label = f"0 {values}"
                with open(f"{root}{labelsPath}{newFileName}.txt", "w") as f:
                    f.write(label)
                # Renaming the file
                os.rename(currentFile, newFile)
                print(newFile)
            line += 1
