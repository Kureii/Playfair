from GUI import runQML
from Fce import GenGrid

if __name__ == '__main__':
    GenGrid("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    GUI = runQML()
    GUI.exec()