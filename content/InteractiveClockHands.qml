import QtQuick 6.2

Item {
    Rectangle {
        id: container

        property real centerX: 200
        property real centerY: 200

        x: -200
        y: -200

        width: 400
        height: 400
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onReleased: (mouse) => {
                var clock_hand = hour_hand.state === "dragged" ? hour_hand : minute_hand;

                clock_hand.state = "idle";
                mouse.accepted = false;
            }
            onPositionChanged: (mouse) => {
                var dragged = hour_hand.state === "dragged" || minute_hand.state === "dragged";

                var handAngle = 0.0;
                var angleCorrection = 0.0;

                if (dragged) {
                    var clock_hand = hour_hand.state === "dragged" ? hour_hand : minute_hand;

                    var diffX = mouse.x - container.centerX;
                    var diffY = mouse.y - container.centerY;

                    if (diffX === 0 && diffY === 0) {
                        handAngle = 0;
                    } else if (diffX === 0) {
                        if (diffY > 0) {
                            handAngle = 0;
                        } else {
                            handAngle = 180;
                        }
                    } else if (diffY === 0) {
                        if (diffX > 0) {
                            handAngle = -90;
                        } else {
                            handAngle = 90;
                        }
                    } else {
                        if (diffY > 0) {
                            if (diffX > 0) {
                                angleCorrection = -90;
                            } else {
                                angleCorrection = 90;
                            }
                        } else {
                            if (diffX > 0) {
                                angleCorrection = -90;
                            } else {
                                angleCorrection = 90;
                            }
                        }
                        handAngle = Math.atan(diffY / diffX) * 180.0 / Math.PI + angleCorrection;
                        clock_hand.handAngle = handAngle;
                    }

                    mouse.accepted = false;
                }
            }
        }

        ClockHand {
            id: hour_hand

            itemX: container.centerX
            itemY: container.centerY
            itemWidth: 10
            itemHeight: 100
        }

        ClockHand {
            id: minute_hand

            itemX: container.centerX
            itemY: container.centerY
            itemWidth: 8
            itemHeight: 150
        }
    }
}
