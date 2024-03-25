import QtQuick 6.2

Item {
    id: clock_hand

    property real itemX: 0
    property real itemY: 0
    property real itemWidth: 10
    property real itemHeight: 100
    property real handAngle: 180.0

    Rectangle {

        x: itemX - itemWidth / 2
        y: itemY

        color: "black"
        width: itemWidth
        height: itemHeight

        transform: Rotation {
            id: hand_rotation

            origin.x: itemWidth / 2
            origin.y: 0
            angle: handAngle
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: (mouse) => {
                clock_hand.state = "dragged";
                mouse.accepted = false;
            }
        }

        states: [
            State {
                name: "idle"
            },
            State {
                name: "dragged"
            }
        ]
    }
}
