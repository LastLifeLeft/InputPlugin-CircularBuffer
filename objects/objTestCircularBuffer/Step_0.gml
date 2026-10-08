// Feather disable all

++stepCount;

if (not testDone)
{
    //Plug-ins initialize on Input's first collect, so wait a step before testing
    if (stepCount < 2) exit;

    try
    {
        testResult = TestCircularBuffer();
    }
    catch(_error)
    {
        show_debug_message("[CircularBuffer test] EXCEPTION " + string(_error.longMessage) + " " + string(_error.stacktrace));
        testResult = { passed: 0, failed: 1 };
    }
    testDone = true;

    if (exitAfterTest)
    {
        game_end();
        exit;
    }

    StartDemo();
    exit;
}

if (keyboard_check_pressed(ord("1"))) replayDelay = max(0, replayDelay - 1);
if (keyboard_check_pressed(ord("2"))) replayDelay = min(INPUT_CIRCULAR_BUFFER_SIZE - 1, replayDelay + 1);
if (keyboard_check_pressed(ord("R"))) StartDemo();

//Store this step's live input
InputCircularBufferRecord(frame, 0);

//Live input
Move(live);

//Browse back and read the same checkers
var _replayFrame = frame - replayDelay;
if (_replayFrame >= 0)
{
    InputCircularBufferSeek(_replayFrame);
    Move(replay);
    replayDuration = InputDuration(INPUT_VERB.ACTION, 0);
    InputCircularBufferSeek(undefined);
}

++frame;
