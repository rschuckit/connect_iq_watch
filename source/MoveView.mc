using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor as ActMonitor;
using Toybox.Math as Math;
class MoveView extends Ui.WatchFace {

	var backgrounds;
	var stepGoal; 
	var imageIndex;
	var numImages;

    function initialize() {
 
        WatchFace.initialize();
        stepGoal = ActMonitor.getInfo().stepGoal;
        numImages = 5;
        imageIndex = 0;
        backgrounds = new [numImages];
    }

    //! Load your resources here
    function onLayout(dc) {
    	var yos = Ui.loadResource(Rez.Drawables.yos);
    	var badlands = Ui.loadResource(Rez.Drawables.badlands);
    	backgrounds[0] = badlands;
    	backgrounds[1] = yos;
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
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        
        var distance = ActMonitor.getInfo().distance;
        distance = distance * 6.213 * Math.pow(10, -6);
        distance = distance.format("%.2f");
        
        var steps = ActMonitor.getInfo().steps;
        
        if (steps >= stepGoal/numImages * (imageIndex + 1)) {
        	imageIndex++;
        }

        // Get the current time
        var clockTime = Sys.getClockTime();
        var adjustedMin = clockTime.min;
        var adjustedHour = clockTime.hour % 12;
        if (clockTime.min < 10) {
        	adjustedMin = "0" + clockTime.min; 
        }
        
        var timeString = Lang.format("$1$:$2$", [adjustedHour, adjustedMin]);

        // Draw the time
        dc.drawBitmap(0, 0, backgrounds[imageIndex]);
        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 2;
        y = dc.getHeight() / 3;
    	dc.drawText(x, y, Gfx.FONT_LARGE, timeString, Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(x, y + 50, Gfx.FONT_MEDIUM, steps + "/" + (stepGoal/numImages * (imageIndex + 1)), Gfx.TEXT_JUSTIFY_CENTER);
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
