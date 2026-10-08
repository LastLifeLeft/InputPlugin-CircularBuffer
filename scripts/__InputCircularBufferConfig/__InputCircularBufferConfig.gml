// Feather disable all

// Number of frames the circular buffer keeps. This is how far back you can browse with
// `InputCircularBufferSeek()` and the other functions that take a frame.
// Memory and work per frame scale with `INPUT_CIRCULAR_BUFFER_SIZE * InputVerbCount() * INPUT_MAX_PLAYERS`.
#macro INPUT_CIRCULAR_BUFFER_SIZE  20

// Priority of the plug-in's `INPUT_PLUG_IN_CALLBACK.UPDATE_PLAYER` callback. Must be negative so
// that it runs after Input has updated verb state natively. Other plug-ins that post-process verb
// state should use a lower priority if they want to see browsed state.
#macro INPUT_CIRCULAR_BUFFER_CALLBACK_PRIORITY  -1
