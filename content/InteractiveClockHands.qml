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
                        var oldHandAngle = clock_hand.handAngle;
                        var angleDiffCounterClockwise = (handAngle - oldHandAngle) % 360;
                        var angleDiffClockwise = angleDiffCounterClockwise > 0.0
                                           ? angleDiffCounterClockwise - 360.0 : angleDiffCounterClockwise + 360.0;
                        // Checkng if clockhand made complete rotation
                        var angleDiff = Math.abs(angleDiffCounterClockwise) < Math.abs(angleDiffClockwise)
                                           ? angleDiffCounterClockwise : angleDiffClockwise;

                        var hourHandAngle = hour_hand.state === "dragged"
                                           ? hour_hand.handAngle + angleDiff : hour_hand.handAngle + angleDiff / 12;
                        hourHandAngle = hourHandAngle % 360;
                        hourHandAngle = hourHandAngle >= 0 ? hourHandAngle : hourHandAngle + 360.0;

                        var minuteHandAngle = minute_hand.state === "dragged"
                                           ? minute_hand.handAngle + angleDiff : minute_hand.handAngle + angleDiff * 12;
                        minuteHandAngle = minuteHandAngle % 360;
                        minuteHandAngle = minuteHandAngle >= 0 ? minuteHandAngle : minuteHandAngle + 360.0;

                        hour_hand.handAngle = hourHandAngle;
                        minute_hand.handAngle = minuteHandAngle;

                        var hourTimeAngle = (hourHandAngle - 180.0);
                        hourTimeAngle = hourTimeAngle > 0 ? hourTimeAngle : hourTimeAngle + 360.0;
                        var minuteTimeAngle = (minuteHandAngle - 180.0);
                        minuteTimeAngle = minuteTimeAngle > 0 ? minuteTimeAngle : minuteTimeAngle + 360.0;

                        var hours =  Math.floor(hourTimeAngle / 30);
                        hours = hours == 0 ? 12 : hours;
                        time_text.hours = hours;
                        var minutes = Math.floor(minuteTimeAngle / 6);
                        time_text.minutes = minutes;
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

        TimeText {
            id: time_text

            x: container.centerX
            y: container.centerY

            hours: 12
            minutes: 0
        }
    }
}
