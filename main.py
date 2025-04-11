import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl

from modules.VoltageController import VoltageController
import assets.rc_resources as resources

if __name__ == "__main__":
    resources.qInitResources()
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Register custom QML import path
    qml_import_path = os.path.join(os.path.dirname(__file__), "assets")
    engine.addImportPath(qml_import_path)

    # Initialize modules
    voltage_controller = VoltageController()
    engine.rootContext().setContextProperty("voltage_controller", voltage_controller)

    qml_file = os.path.join(os.path.dirname(__file__), "assets", "main.qml")
    engine.load(QUrl.fromLocalFile(qml_file))
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
