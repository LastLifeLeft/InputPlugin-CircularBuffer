// Feather disable all

// Every step, player 0's live input is recorded into the circular buffer. The cyan square moves
// with live input; the red square browses the buffer `replayDelay` frames back and moves with
// exactly the same Input checkers, so it replays your movement late.

stepCount     = 0;
testDone      = false;
testResult    = undefined;
exitAfterTest = (environment_get_variable("INPUT_CIRCULAR_BUFFER_TEST_EXIT") == "1");

replayDelay = 10;
frame       = 0;

live   = { x: 200, y: 340, flash: 0 };
replay = { x: 200, y: 470, flash: 0 };
replayDuration = 0;

Move = function(_square)
{
    _square.x += 4*InputX(INPUT_CLUSTER.NAVIGATION, 0);
    _square.y += 4*InputY(INPUT_CLUSTER.NAVIGATION, 0);
    _square.flash = InputPressed(INPUT_VERB.ACTION, 0)? 12 : max(0, _square.flash - 1);
}

StartDemo = function()
{
    InputCircularBufferReset(0);
    frame  = 0;
    live   = { x: 200, y: 340, flash: 0 };
    replay = { x: 200, y: 470, flash: 0 };
}
