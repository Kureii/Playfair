class Playfair():
    def __init__(self, abcList, text, encode = True):
        self.abcList = abcList
        self.txt = text
        
        if encode:
            pass
        else:
            pass
        self.output = ""


Petrklic =['P','E','T','R','K','L','I','C','A','B','D','F','G','H','M','N','O','Q','S','U','V','W','X','Y','Z']
print(Playfair(Petrklic, "PRILS ZLUTOUCKY KUN UPEL DABELSKE ODY").output)