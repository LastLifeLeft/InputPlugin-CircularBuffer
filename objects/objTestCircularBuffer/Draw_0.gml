// Feather disable all

if (not testDone) exit;

var _DrawSquare = function(_square, _colour)
{
    var _x = ((_square.x mod room_width) + room_width) mod room_width;
    var _y = 300 + ((((_square.y - 300) mod 240) + 240) mod 240);
    var _size = 16 + _square.flash;

    draw_set_colour((_square.flash > 0)? c_white : _colour);
    draw_rectangle(_x - _size, _y - _size, _x + _size, _y + _size, false);
}

_DrawSquare(live,   c_aqua);
_DrawSquare(replay, c_red);

//Timeline of the buffer: one column per frame (newest on the right), one row per verb
var _size   = INPUT_CIRCULAR_BUFFER_SIZE;
var _newest = InputCircularBufferGetNewestFrame();
var _left   = 120;
var _top    = 90;
var _cell   = 18;

draw_set_colour(c_white);
draw_set_halign(fa_right);
for(var _v = 0; _v < InputVerbCount(); ++_v)
{
    draw_text(_left - 6, _top + _v*_cell - 2, InputVerbGetExportName(_v) ?? $"verb {_v}");
}
draw_set_halign(fa_left);

for(var _c = 0; _c < _size; ++_c)
{
    var _f = _newest - (_size - 1) + _c;
    if (_f < 0) continue;

    var _x = _left + _c*_cell;
    for(var _v = 0; _v < InputVerbCount(); ++_v)
    {
        draw_set_colour(InputCircularBufferCheck(_v, _f, 0)? (InputCircularBufferPressed(_v, _f, 0)? c_yellow : c_lime) : c_dkgray);
        draw_rectangle(_x, _top + _v*_cell, _x + _cell - 2, _top + (_v + 1)*_cell - 2, false);
    }

    if (_f == _newest - replayDelay)
    {
        draw_set_colour(c_red);
        draw_rectangle(_x - 1, _top - 2, _x + _cell - 1, _top + InputVerbCount()*_cell, true);
    }
}

draw_set_colour(c_white);

var _string = "";
_string += $"Arrows/WASD move, Enter flashes, 1/2 change replay delay ({replayDelay} frames), R restarts\n";
_string += $"buffer holds frames {InputCircularBufferGetOldestFrame()} to {_newest}, replay reads frame {_newest - replayDelay}   ACTION duration there: {is_infinity(replayDuration)? "-" : replayDuration}";

draw_text(10, 10, _string);
