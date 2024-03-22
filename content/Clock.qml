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
            x: 200
            y: 200
            itemRotation: index * 30
        }
    }

    Repeater {
        model: 12

        ClockText {
            x: 200
            y: 200
            hour: (index + 5) % 12 + 1
            itemRotation: index * 30
        }
    }

    ClockHand {
        x: 200
        y: 200
        item_width: 10
        item_height: 100
    }
}
