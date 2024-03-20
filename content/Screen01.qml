import QtQuick 6.2
import QtQml
import InteractiveClock

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: Constants.backgroundColor

    Clock {
        id: clock
        width: 400
        height: 400
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }


    SequentialAnimation {
        id: animation

        ColorAnimation {
            id: colorAnimation1
            target: rectangle
            property: "color"
            to: "#2294c6"
            from: Constants.backgroundColor
        }

        ColorAnimation {
            id: colorAnimation2
            target: rectangle
            property: "color"
            to: Constants.backgroundColor
            from: "#2294c6"
        }
    }

    states: [
        State {
            name: "clicked"
            when: button.checked

            PropertyChanges {
                target: label
                text: qsTr("Button Checked")
            }
        }
    ]
}
