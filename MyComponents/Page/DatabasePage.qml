import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import MyComponents 1.0
import Models 1.0

Page {
    id: databasePage

    width: 1000
    height: 600

    property alias model: view.model

    signal openDatabase(string pathname)

    actions: pageActions

    Component {
        id: databaseDelegate

        Item {
            id: delegate
            width: parent.width
            height: 40

            Rectangle {
                id: hover
                anchors.fill: parent
                color: theme.hoverColor
                visible: mouseArea.containsMouse
            }

            Rectangle {
                id: highlight
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: theme.highlightGradientStart }
                    GradientStop { position: 1.0; color: theme.highlightGradientEnd }
                }
                visible: mouseArea.pressed
            }

            Text {
                id: delegateTextColumn
                anchors {left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10}
                height: contentHeight
                width: contentWidth
                clip: true

                font.pixelSize: 14
                text: name
                color: mouseArea.pressed ? theme.textHighlightColor : theme.textColor
            }

            Image {
                id: arrow
                source: "../Image/arrow.png"
                height: parent.height/2
                width: height
                anchors {verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: 10}
            }

            Colorize {
                anchors.fill: arrow
                source: arrow
                hue: 0.0
                saturation: 0.5
                lightness: 1.0
                visible: mouseArea.pressed
            }

            Rectangle {
                id: separatorBottom
                width: parent.width
                height: 1
                anchors {left: parent.left; bottom: parent.bottom}
                color: theme.separatorColor
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: delegate.ListView.view.select(path)
            }
        }
    }

    ListView {
        id: view
        anchors.fill: parent
        delegate: databaseDelegate

        function select(pathname) {
            openDatabase(pathname)
        }
    }

    onActionClicked: {
        if (name == "Quit")
            Qt.quit()
        else if (name == "New database")
            fileDialog.open()
    }

    ListModel {
        id: pageActions
        ListElement {
            name: "New database"
            description: "Create a new database"
            icon: "../Image/table.png"
        }
        ListElement {
            name: "Quit"
            description: "Exit application"
            icon: "../Image/exit.png"
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose database file to create"
        nameFilters: [ "Databse (*.sql)" ]
        selectExisting: false
        onAccepted: openDatabase(fileUrl)
    }
}
