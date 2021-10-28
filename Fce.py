import math

def GenGrid(str):
    tmp = str
    for k in range(3):
        if k == 0:
            str = str.replace("J", "")
        elif k == 1:
            str = str.replace("W", "")
        else:
            str = str.replace("Q", "")
        svg = "<svg version='1.1'\n"\
            "    width='504' height='504'\n"\
            "    xmlns='http://www.w3.org/2000/svg'>\n\n"\
            "     <style type='text/css'>\n"\
            "        @font-face {\n"\
            "            font-family: 'Fira Code', monospace;\n"\
            "            rc: url('fonts/FiraCode-Medium.ttf');\n"\
            "        }\n"\
            "    </style>\n\n"\
            "        <rect width='504' height='504' x='0' y='0' fill='#3fa108'/>\n\n"
        for i in range(5):
            for j in range(5):
                svg+="        "
                svg += f"<rect width='96' height='96' x='{j * 10}4' y='{i * 10}4' fill='#201e1b'  />\n"
                svg+="        "
                svg += f"<text x='{j}37.5' y='{i}67' font-size='48' ext-anchor='middle' font-family="
                svg += f"'Fira Code' fill='#e4f8ff'>{str[i * 5 + j]}</text>\n\n"
        svg +="</svg>"
        if k == 0:
            f = open("icons/EngGrid.svg", "w")
            f.write(svg)
            f.close()
        elif k == 1:
            f = open("icons/CsVGrid.svg", "w")
            f.write(svg)
            f.close()
        else:
            f = open("icons/CsKGrid.svg", "w")
            f.write(svg)
            f.close()
        str = tmp

class Playfair():
    def __init__(self, keyList, text, supplement, encode = True, eng = True, spaces = 5):
        keyList = keyList
        txt = ' '.join(text.split())
        self.sup = supplement
        self.eng = eng
        self.spcRep = ""
        self.output = ""
        if encode:
            self.output = self.enc(txt, keyList)
            self.output = self.Steps(self.output, spaces)
        else:
            txt = txt.replace(" ","")
            self.output = self.dec(txt, keyList)

    def __str__(self):
        return self.output
    
    def makeDict(self, myList):
        myDict = {}
        for i in range(len(myList)):
            myDict[myList[i]] = i
        return myDict

    def makeInvDict(self, myList):
        myDict = {}
        for i in range(len(myList)):
            myDict[i] = myList[i]
        return myDict

    def prepareString(self, txt):
        txtList = []
        if self.eng:
            txt = txt.replace("J", "I")
        else:
            txt = txt.replace("Q", "K")
        if txt[len(txt)-1] == " ":
            txt = txt[0 : -1]
        txt = txt.replace(" ", self.sup)
        for i in range(len(txt)):
            txtList.append(txt[i])
        return self.dup(txtList)

    def dup(self, myList):
        if len(myList) % 2 != 0:
            myList.append(self.sup)
        for i in range(0, len(myList), 2):
            if myList[i] == myList[i + 1]:
                myList.insert(i + 2, self.sup)
                myList.insert(i + 1, self.sup)
                if len(myList)- 1 != i:
                    self.dup(myList)
        return myList

    def remSpc(self, myStr):
        return myStr.replace(" ", "")

    def spaceSolver(self, txt):
        print("Space Solver fce")
        txt = list(txt)
        finalTxt = ""
        for i in range(0, len(txt), 2):
            if i + 3 < len(txt):
                if txt[i] == self.sup: 
                    if txt[i + 1] == txt[i + 3]:
                        txt[i] = ""
                        txt[i + 2] = ""
                    else:
                        txt[i] = " "
                elif txt[i + 1] == self.sup:
                    if txt[i] == txt[i + 2]:
                        txt[i + 1] = ""
                        txt[i + 3] = ""
                    else:
                        txt[i + 1] = " "
        if txt[-1] == self.sup:
            txt = txt[0:-1]
        for i in txt:
            finalTxt += i
        return finalTxt
        
                    
    
    def enc(self, myStr, myKey):
        myList = self.prepareString(myStr)
        keyDict = self.makeDict(myKey)
        invKeyDict = self.makeInvDict(myKey)
        for i in range(0,len(myList), 2):
            tmp = keyDict[myList[i]]
            tmp2 = keyDict[myList[i + 1]]
            # Column shift
            if tmp % 5 == tmp2 % 5:
                myList[i] = invKeyDict[(tmp + 5) % 25]
                myList[i + 1] = invKeyDict[(tmp2 + 5) % 25]
            elif tmp // 5 == tmp2 // 5:
                tmp3 =tmp // 5 * 5
                myList[i] = invKeyDict[((tmp + 1) % 5) + tmp3]
                myList[i + 1] = invKeyDict[((tmp2 - tmp3 + 1) % 5) + tmp3]
            else:
                if tmp % 5 > tmp2 % 5:
                    myList[i] = invKeyDict[tmp - (tmp % 5 - tmp2 % 5)]
                    myList[i + 1] = invKeyDict[tmp2 - (tmp2 % 5 - tmp % 5)]
                else:
                    myList[i] = invKeyDict[tmp - (tmp % 5 - tmp2 % 5)]
                    myList[i + 1] = invKeyDict[tmp2 - (tmp2 % 5 - tmp % 5)]
        str = ""
        for i in myList:
            str += i
        return str

    def dec(self, myStr, myKey):
        myStr = self.remSpc(myStr)
        myList = list(myStr)
        keyDict = self.makeDict(myKey)
        invKeyDict = self.makeInvDict(myKey)
        for i in range(0,len(myList), 2):
            tmp = keyDict[myList[i]]
            tmp2 = keyDict[myList[i + 1]]
            # Column shift
            if tmp % 5 == tmp2 % 5:
                myList[i] = invKeyDict[(tmp - 5) % 25]
                myList[i + 1] = invKeyDict[(tmp2 - 5) % 25]
            elif tmp // 5 == tmp2 // 5:
                tmp3 =tmp // 5 * 5
                myList[i] = invKeyDict[((tmp - 1) % 5) + tmp3]
                myList[i + 1] = invKeyDict[((tmp2 - tmp3 - 1) % 5) + tmp3]
            else:
                if tmp % 5 > tmp2 % 5:
                    myList[i] = invKeyDict[tmp + (tmp2 % 5 - tmp % 5)]
                    myList[i + 1] = invKeyDict[tmp2 + (tmp % 5 - tmp2 % 5)]
                else:
                    myList[i] = invKeyDict[tmp + (tmp2 % 5 - tmp % 5)]
                    myList[i + 1] = invKeyDict[tmp2 + (tmp % 5 - tmp2 % 5)]
        str = ""
        for i in myList:
            str += i
        str = self.spaceSolver(str)
        return str

    def Steps(self, string, steps):
        Lenght = len(string)
        iterations = math.ceil(Lenght / steps)
        newString =""
        for i in range(iterations):
            for j in range(steps):
                index = i * steps + j
                if index < Lenght:
                    newString += string[index]
            newString += " "
        
        return newString


def IlChar(abc, text):
    output = []
    if abc.isupper():
        text = text.upper()
    for i in text:
        if i not in abc:
            output.append(i)
    output =list(dict.fromkeys(output))
    return output

def makeList(str):
    output = []
    for i in str:
        output.append(i)
    return output
