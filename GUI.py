import os
import sys
from PySide6.QtCore import *
from PySide6.QtQml import *
from PySide6.QtWidgets import *
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import *
import Fce


class GetData(QObject):
    def __init__(self):
        QObject.__init__(self)

    ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    keyList =[]
    RepSpc = ""
    myInputText = Signal(str)
    openText = Signal(str)
    encodeText = Signal(str)
    illegalChars = Signal(list)
    repCount = Signal(int)
    Spaces = 5
    langList = [0]
    eng = True


    @Slot(str)
    def getKey(self, key):
        myListKey = list(dict.fromkeys(key))
        myKey = ""
        myAlpha = self.ALPHA
        for i in myListKey:
            myKey += i
        for i in myKey:
            myAlpha = myAlpha.replace(i, "")
        self.AlphaKey = myKey + myAlpha
        Fce.GenGrid(self.AlphaKey)
        for i in self.AlphaKey:
            self.keyList.append(i)

    @Slot(bool)
    def getInputIndex(self, index):
        self.InputIndex = index

    @Slot(str)
    def getInput(self, myInput):
        self.Text = ""
        if self.InputIndex:
            if os.name == "nt":
                File = myInput[8:]
            else:
                File = myInput[7:]
            f = open(File, "r")
            myText = f.read()
            myText = myText.upper()
            f.close()
     
        else:
            myText = myInput

        for line in myText:
            oneLine = line.rstrip("\n")
            self.Text += oneLine

        self.myInputText.emit(self.Text)

    @Slot(list)
    def getLang(self, eng):
        self.langList = eng
        if len(eng) == 1:
            self.eng = True
        else:
            self.eng = False
        

    @Slot(str)
    def getRepSpc(self, rpSp):
        self.RepSpc = rpSp

    @Slot(int)
    def getSpaces(self, spc):
        self.Spaces = spc

    @Slot()
    def encode(self):
        mykey = self.AlphaKey
        myText = self.Text
        if len(self.langList) == 1:
            mykey = mykey.replace("J", "")
            myText = myText.replace("J", "I")
        elif self.langList[1] == 0:
            mykey = mykey.replace("W", "")
            myText = myText.replace("W", "V")
        else:
            mykey = mykey.replace("Q", "")
            myText = myText.replace("Q", "K")
        keyList = Fce.makeList(mykey)
        self.ilCh = []
        ilCh = Fce.IlChar(mykey, myText)
        indx = 0
        for i in ilCh:
            if i == " ":
                del ilCh[indx]
                break
            indx += 1
        if not ilCh:
            self.openText.emit(myText)
            self.encodeText.emit(Fce.Playfair(keyList, myText, self.RepSpc, True, self.eng, self.Spaces).output)
        else:
            self.openText.emit(myText)
            self.repCount.emit(len(ilCh))
            self.illegalChars.emit(ilCh)
            self.ilCh = ilCh

    @Slot()
    def decode(self):
        mykey = self.AlphaKey
        if len(self.langList) == 1:
            mykey = mykey.replace("J", "")
        elif self.langList[1] == 0:
            mykey = mykey.replace("W", "")
        else:
            mykey = mykey.replace("Q", "")
        keyList = Fce.makeList(mykey)
        ilCh = Fce.IlChar(mykey, self.Text)
        indx = 0
        for i in ilCh:
            if i == " ":
                del ilCh[indx]
                break
            indx += 1
        if not ilCh:
            self.openText.emit(Fce.Playfair(keyList, self.Text, self.RepSpc, False, self.eng, self.Spaces).output)
            self.encodeText.emit(self.Text)
        else:
            self.repCount.emit(len(ilCh))


    @Slot(list)
    def repair(self, myList):
        myAbc = self.Alpha
        for i in range(len(self.ilCh)):
            if myList[i][0] == 0:
                self.Text = self.Text.replace(self.ilCh[i], "")
            elif myList[i][0] == 1:
                self.Alpha += self.ilCh[i]
            else:
                self.Text = self.Text.replace(self.ilCh[i], self.myAbcList[myList[i][1]])

    @Slot()
    def makeDefaultGrids(self):
        Fce.GenGrid("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    @Slot(str)
    def getSaveFile(self, path):
        if os.name == "nt":
            File = path[8:]
        else:
            File = path[7:]
        f = open(File, "w")
        f.write(self.outText)
        f.close()

  #-------------------------------------------      

class runQML():
    def __init__(self, dic= {}):
        sys_argv = sys.argv
        sys_argv += ['--style', 'Fusion']
        self.app = QApplication(sys_argv)
        app_icon = QIcon()
        app_icon.addFile('icons/TaskBar.svg')
        self.app.setWindowIcon(app_icon)
        QFontDatabase.addApplicationFont('fonts/Poppins-Medium.ttf')
        QFontDatabase.addApplicationFont('fonts/Roboto-Medium.ttf')
        self.engine = QQmlApplicationEngine()

        self.getD = GetData()
        self.engine.rootContext().setContextProperty("myData", self.getD)
        self.engine.load('Main.qml')

    def exec(self):
        if not self.engine.rootObjects():
            return -1     
        return self.app.exec()

if __name__ == '__main__':
    GUI = runQML()
    GUI.exec()