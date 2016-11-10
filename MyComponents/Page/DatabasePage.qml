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

    ListView {
        id: view
        anchors.fill: parent
        delegate: DatabaseDelegate { }
        clip: true

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
