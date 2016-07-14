using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor as ActMonitor;
using Toybox.Math as Math;
class MoveView extends Ui.WatchFace {

	var background;

    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
    	background = Ui.loadResource(Rez.Drawables.grand_canyon);
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Set background color
        dc.clear();
        dc.drawBitmap(0, 0, background);
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        
        var steps = ActMonitor.getInfo().distance;
        steps = steps * 6.213 * Math.pow(10, -6);

        // Get the current time
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min]);

        // Draw the time
        dc.drawBitmap(0, 0, background);
        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 2;
        dc.drawText(x, y, Gfx.FONT_LARGE, timeString, Gfx.TEXT_JUSTIFY_CENTER);
        y = dc.getHeight() / 3;
    	dc.drawText(x, y, Gfx.FONT_SMALL, "The time is " + steps, Gfx.TEXT_JUSTIFY_CENTER);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
