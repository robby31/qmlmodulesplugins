import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0
import MyComponents 1.0

ApplicationWindow {
    id: mainWindow

    width: 600
    height: 400
    minimumHeight: 400
    minimumWidth: 570
    visible: true

    property int headerHeight: 60

    property ListModel modelButtons
    property var controller

    property alias state: mainArea.state
    property alias states: mainArea.states

    property var theme: AirbusThemeDefault { }

    property Component pages

    Rectangle {
        id: mainArea
        anchors.fill: parent

        state: modelButtons.get(0).state

        Header {
            id: header
            anchors {left: parent.left; right: parent.right; top: parent.top}
            height: headerHeight

            ExclusiveGroup {
                id: tabGroup
            }

            Row {
                height: parent.height
                anchors {verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 320}

                Repeater {
                    model: modelButtons

                    Tab {
                        id: accountsTab
                        width: height
                        height: parent.height
                        icon: model.icon ? model.icon : ""
                        title: model.title
                        exclusiveGroup: tabGroup
                        onClicked: mainArea.state = model.state
                        checked: index==0
                    }
                }
            }

            ToggleButton {
                id: tb
                width: height
                height: parent.height
                iconSource: "image/menu.png"
                text: "Menu"
                anchors { verticalCenter: parent.verticalCenter; right: parent.right }
                onClicked: pagesLoader.item.toggleMenu()
            }
        }

        Loader {
            id: pagesLoader
            anchors.fill: parent
            sourceComponent: pages
        }

        PopupBox {
            id: popupBox
            anchors.fill: parent
            pop: uiServices.popupVisible
            text: uiServices.popupText
            popupType: uiServices.popupType
            onCloseTriggered: uiServices.popupVisible = false
        }

        BusyIndicator {
            id: busyindicator
            anchors.fill: parent
            activity: controller ? controller.activity : ""
            activityProgress: controller ? controller.activityProgress : ""
            visible: controller ? controller.busy : false
            onCancel: controller.abortProcess()
        }
    }
}
