import QtQuick 2.0
import Models 1.0

Item {
    width: parent.width
    height: 40

    Loader {
        id: loader
        anchors {left: parent.left; verticalCenter: parent.verticalCenter; right: parent.right}
    }

    Component.onCompleted: {
        if (type == Parameter.TEXT)
            loader.source = "Delegates/TextParameterDelegate.qml"
        else if (type == Parameter.OPENCSVFILE)
            loader.source = "Delegates/OpenCsvFileParameterDelegate.qml"
        else if (type == Parameter.SAVECSVFILE)
            loader.source = "Delegates/SaveCsvFileParameterDelegate.qml"
        else if (type == Parameter.INTEGER)
            loader.source = "Delegates/IntegerParameterDelegate.qml"
        else if (type == Parameter.ENUM)
            loader.source = "Delegates/EnumParameterDelegate.qml"
        else if (type == Parameter.CHECKED_ENUM)
            loader.source = "Delegates/CheckedEnumParameterDelegate.qml"
        else
            loader.source = "Delegates/TextParameterDelegate.qml"
    }
}
