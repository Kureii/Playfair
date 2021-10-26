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

    Alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    openText = Signal(str)


    @Slot(str)
    def getKey(self, key):
        myListKey = list(dict.fromkeys(key))
        myKey = ""
        myAlpha = self.Alpha
        for i in myListKey:
            myKey += i
        for i in myKey:
            myAlpha = myAlpha.replace(i, "")
        self.AlphaKey = myKey + myAlpha
        Fce.GenGrid(self.AlphaKey)

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

        self.openText.emit(self.Text)
            

        

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