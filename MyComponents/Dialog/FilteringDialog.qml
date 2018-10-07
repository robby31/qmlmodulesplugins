import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import MyComponents 1.0

Rectangle {
    id: filteringDialog

    property alias columnModel: columns.model
    property alias columnDataModel: listData.model

    signal ok()
    signal columnSelected(var name)

    width: 500
    height: 300
    border.color: theme.darkColor

    Rectangle {
        id: titleArea
        width: parent.width
        height: 40
        color: theme.headerBackgroundColor
        anchors {left: parent.left; top: parent.top}

        Text {
            id: titleText
            width: contentWidth
            anchors {left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10}
            font.pixelSize: 16
            color: theme.textHighlightColor
            text: "Filtering"
        }

        Rectangle {
            id: titleSeparator
            width: parent.width
            height: 1
            anchors {left: parent.left; bottom: parent.bottom}
            color: theme.separatorColor
        }
    }

    ListView {
        id: columns
        width: filteringDialog.width*1/3
        anchors {top: titleArea.bottom; left: parent.left; bottom: separator.top}
        focus: true
        delegate: FilteringColumnDelegate { }
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        clip: true

        onCurrentIndexChanged: columnSelected(model.get(currentIndex, "name"))
    }

    RowLayout {
        id: actionButtons
        spacing: 10
        anchors {
            top: columns.top
            left: columns.right
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }

        TextField {
            id: filteringTextField
            Layout.fillWidth: true
            placeholderText: "Filtering"
            text: columnDataModel ? columnDataModel.textFilter : ""

            onAccepted: {
                if (columnDataModel)
                    columnDataModel.textFilter = text
            }
        }

        Rectangle {
            id: selectAllButton
            width: textButton.width*1.2
            height: textButton.height*1.2
            color: selectAllButtonMouseArea.pressed? theme.highlightSelectColor : theme.highlightColor
            radius: 10
            border.color: theme.separatorColor

            Text {
                id: textButton
                width: contentWidth
                height: contentHeight
                anchors.centerIn: parent
                font.pixelSize: 12
                text: (listData.model && !listData.model.allchecked) ? "Select All" : "Unselect All"
            }

            MouseArea {
                id: selectAllButtonMouseArea
                anchors.fill: parent
                onClicked: {
                    if (listData.model.isFiltered)
                    {
                        var rowIndex
                        if (!listData.model.allchecked)
                        {
                            for (rowIndex = 0; rowIndex < listData.model.rowCount; ++rowIndex)
                                listData.model.setDataByStringRole(rowIndex, true, "checked")
                        }
                        else
                        {
                            for (rowIndex = 0; rowIndex < listData.model.rowCount; ++rowIndex)
                                listData.model.setDataByStringRole(rowIndex, false, "checked")
                        }
                    }
                    else
                    {
                        if (!listData.model.allchecked)
                            listData.model.selectAll()
                        else
                            listData.model.unSelectAll()
                    }
                }
            }
        }
    }

    ListView {
        id: listData
        width: parent.width-columns.width
        height: parent.height-titleArea.height
        anchors {top: actionButtons.bottom; topMargin: 10; left: columns.right; right: parent.right; bottom: columns.bottom}
        delegate: CheckedListDelegate{id: delegate; width: parent.width}
        focus: true
        highlightFollowsCurrentItem: false
        clip: true

        ScrollIndicator {
            id: scrollIndicator
            width: 10
            height: parent.height
            anchors {top: parent.top; right: parent.right}
            handleSize: height>0 ? listData.visibleArea.heightRatio * height : 0
            handlePosition: height>0 ? listData.visibleArea.yPosition * height : 0
            opacity: listData.moving? 1.0 : 0.0
        }
    }

    Rectangle {
        id: separator
        width: parent.width
        height: 40
        border.color: theme.darkColor
        anchors {left: parent.left; bottom: parent.bottom}

        Button {
            id: okButton
            text: "Ok"
            anchors {verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: 10}
            onClicked: ok()
        }
    }
}
