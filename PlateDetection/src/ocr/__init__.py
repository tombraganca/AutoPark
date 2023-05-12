import re
import easyocr

reader = easyocr.Reader(['pt'])

def validate_ocr(img):
    orc_results = reader.readtext(img, allowlist ='ABCDEFGHIJKLMNOQPRSTUVXYZ01234567-')
    # print(orc_results)
    for result in orc_results:
        test = re.fullmatch("^[A-Z]{3}[\-]?[0-9][0-9A-Z][0-9]{2}", result[1])
        if test == None:
            try:
                ABC = ''
                NUM = ''
                ocrText = reader.readtext(img, allowlist ='ABCDEFGHIJKLMNOQPRSTUVXYZ')
                ocrNumber = reader.readtext(img, allowlist ='01234567')
                # print(ocrText, ocrNumber)

                for letters in ocrText:
                    if len(letters[1]) == 7:
                        ABC = letters[1]
                for number in ocrNumber:
                    if len(number[1]) == 7:
                        NUM = number[1]


                res1 = ABC[:3] + NUM[3:4] + ABC[4:5] + NUM[5:]
                res2 = ABC[:3] + NUM[3:]
                # print(res1, res2)
                results = []
                if re.fullmatch("^[A-Z]{3}[\-]?[0-9][0-9A-Z][0-9]{2}", res1) != None:
                    results.append(res1)
                if re.fullmatch("^[A-Z]{3}[\-]?[0-9][0-9A-Z][0-9]{2}", res2) != None:
                    results.append(res2)
                if len(results) == 1:
                    results.append('')
                if len(results) == 2:
                    return results
            except:
                print('fail')
    return None