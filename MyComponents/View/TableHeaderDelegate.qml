import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    color: content.model ? content.model.columnColor(styleData.column) : "transparent"
    border.color: "black"
    border.width: styleData.column === 0 ? 0 : 1
    height: headerText.height

    Text {
        id: headerText
        width: parent.width
        height: contentHeight*1.2
        text: styleData.value
        font.pointSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        color: "white"
    }
    clip: true
}
