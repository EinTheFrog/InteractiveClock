import QtQuick 6.2

Item {
    Rectangle {
        id: circle

        width: 400
        height: 400
        color: "transparent"
        border.color: "black"
        border.width: 5
        radius: 200
    }

    Repeater {
        model: 12

        ClockSegment {
            id: clockSegment0

            x: 200
            y: 200
            transform: Rotation {
                origin.x: 0
                origin.y: 0
                angle: index * 30
            }
        }
    }
}
