import QtQuick 2.3
import QtQuick.Controls 1.2

EditableDelegate {

    editor: Component {
        TextField {
            clip: true
            text: styleData.value

            onAccepted: setData(text)
        }
    }
}
