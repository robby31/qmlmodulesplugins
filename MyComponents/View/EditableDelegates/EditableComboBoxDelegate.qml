import QtQuick 2.3
import QtQuick.Controls 1.2

EditableDelegate {
    id: delegate
    property var comboModel
    property string comboTextRole

    editor: Component {

        ComboBox{
            id: comboBox
            clip: true
            model: delegate.comboModel
            textRole: delegate.comboTextRole
            property bool isInitialised: false

            onCurrentIndexChanged: {
                if (isInitialised)
                    setData(currentText)
            }

            Component.onCompleted: {
                // initialize value in ComboBox
                var index = find(styleData.value)
                if (index !== -1 && index !== currentIndex)
                    currentIndex = index
                isInitialised = true
            }
        }
    }
}

