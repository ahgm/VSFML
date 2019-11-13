//CSFML_WINDOW
module sf

#flag windows -I csfml/include
#flag windows -I csfml/include/SFML
#flag windows -L csfml/lib

#flag windows -l csfml-window

#include "Window.h"

//Clipboard.h
pub fn get_clipboard() string
{
	return tos3(C.sfClipboard_getString())
}
pub fn set_clipboard(text string) {
	C.sfClipboard_setString(text.str)
}

//Types.h
[typedef]
struct C.sfContext
type Context &C.sfContext
//Context.h
pub fn create_context() Context {
	return C.sfContext_create()
}
pub fn destroy_context(ctx Context){
	C.sfContext_destroy(ctx)
}
pub fn active_context(ctx Context,active bool) {
	C.sfContext_setActive(ctx,active)
}

//Cursor.h
pub enum CursorType{
	cursorarrow                  ///< arrow cursor (default)
    cursorarrowwait              ///< busy arrow cursor
    cursorwait                   ///< busy cursor
    cursortext                   ///< i-beam, cursor when hovering over a field allowing text entry
    cursorhand                   ///< pointing hand cursor
    cursorsizehorizontal         ///< horizontal double arrow cursor
    cursorsizevertical           ///< vertical double arrow cursor
    cursorsizetopleftbottomright ///< double arrow cursor going from top-left to bottom-right
    cursorsizebottomlefttopright ///< double arrow cursor going from bottom-left to top-right
    cursorsizeall                ///< combination of sizehorizontal and sizevertical
    cursorcross                  ///< crosshair cursor
    cursorhelp                   ///< help cursor
    cursornotallowed              ///< action not allowed cursor
}
//Types.h
[typedef]
struct C.sfCursor
type Cursor &C.sfCursor

pub fn create_cursor_sys(typ CursorType) Cursor{
    return C.sfCursor_createFromSystem(typ)
}
/*
pub fn create_cursor_pixel(pixels byte) &Cursor{
    return C.sfCursor_createFromPixels(pixels)
}
*/
pub fn destroy_cursor(cursor Cursor) {
    C.sfCursor_destroy(cursor)
}

//Event.h
pub enum EventType {
    closed                 ///< the window requested to be closed (no data)
    resized                ///< the window was resized (data in event.size)
    lostfocus              ///< the window lost the focus (no data)
    gainedfocus            ///< the window gained the focus (no data)
    textentered            ///< a character was entered (data in event.text)
    keypressed             ///< a key was pressed (data in event.key)
    keyreleased            ///< a key was released (data in event.key)
    mousewheelmoved        ///< the mouse wheel was scrolled (data in event.mousewheel) (deprecated)
    mousewheelscrolled     ///< the mouse wheel was scrolled (data in event.mousewheelscroll)
    mousebuttonpressed     ///< a mouse button was pressed (data in event.mousebutton)
    mousebuttonreleased    ///< a mouse button was released (data in event.mousebutton)
    mousemoved             ///< the mouse cursor moved (data in event.mousemove)
    mouseentered           ///< the mouse cursor entered the area of the window (no data)
    mouseleft              ///< the mouse cursor left the area of the window (no data)
    joystickbuttonpressed  ///< a joystick button was pressed (data in event.joystickbutton)
    joystickbuttonreleased ///< a joystick button was released (data in event.joystickbutton)
    joystickmoved          ///< the joystick moved along an axis (data in event.joystickmove)
    joystickconnected      ///< a joystick was connected (data in event.joystickconnect)
    joystickdisconnected   ///< a joystick was disconnected (data in event.joystickconnect)
    touchbegan             ///< a touch event began (data in event.touch)
    touchmoved             ///< a touch moved (data in event.touch)
    touchended             ///< a touch event ended (data in event.touch)
    sensorchanged          ///< a sensor value changed (data in event.sensor)
    count                  ///< keep last -- the total number of event types
}
//Keyboard event parameters
struct C.sfKeyEvent {
    typ     EventType 
    //code    KeyCode   
    alt     bool      
    control bool      
    shift   bool
    system  bool
}
type KeyEvent C.sfKeyEvent
//Text event parameters
struct C.sfTextEvent {
    typ     EventType
    unicode u32
}
type TextEvent C.sfTextEvent
//Mouse move event parameters
struct C.sfMouseMoveEvent{
    typ EventType
    x   int
    y   int
}
type MouseMoveEvent C.sfMouseMoveEvent
//Mouse buttons events parameters
struct C.sfMouseButtonEvent {
    typ    EventType
    //button MouseButton
    x      int 
    y      int
}
type MouseButtonEvent C.sfMouseButtonEvent
//Mouse wheel events parameters
struct C.sfMouseWheelEvent {
    typ   EventType
    delta int
    x     int
    y     int
}
type MouseWheelEvent C.sfMouseWheelEvent
struct C.sfMouseWheelScrollEvent {
    typ   EventType
    wheel C.sfMouseWheelEvent
    delta int
    x     int
    y     int
}
type MouseWheelScrollEvent C.sfMouseWheelScrollEvent
//Joystick axis move event parameters
struct C.sfJoystickMoveEvent {
    typ        EventType
    joystickid u32
    //axis       JoystickAxis
    position   f32
}
type JoystickMoveEvent C.sfJoystickMoveEvent
//Joystick buttons events parameters
struct C.sfJoystickButtonEvent {
    typ        EventType
    joystickid u32
    button     u32
}
type JoystickButtonEvent C.sfJoystickButtonEvent
//Joystick connection/disconnection event parameters
struct C.sfJoystickConnectEvent {
    typ        EventType
    joystickid u32
}
type JoystickConnectEvent C.sfJoystickConnectEvent
//Size events parameters
struct C.sfSizeEvent {
    typ     EventType
    width   u32 
    height  u32
}
type SizeEvent C.sfSizeEvent
//Touch events parameters
struct C.sfTouchEvent {
    typ    EventType
    finger u32
    x      int
    y      int
}
type TouchEvent C.sfTouchEvent
//Sensor event parameters
struct C.sfSensorEvent {
    typ    EventType
    //stype  SensorType
    x      f32     
    y      f32
    z      f32
}
//Event defines a system event and its parameters
struct C.sfEvent
{
    typ              C.sfEventType            ///< Type of the event
    size             C.sfSizeEvent            ///< Size event parameters
    key              C.sfKeyEvent             ///< Key event parameters
    text             C.sfTextEvent            ///< Text event parameters
    mouseMove        C.sfMouseMoveEvent       ///< Mouse move event parameters
    mouseButton      C.sfMouseButtonEvent     ///< Mouse button event parameters
    mouseWheel       C.sfMouseWheelEvent      ///< Mouse wheel event parameters (deprecated)
    mouseWheelScroll C.sfMouseWheelScrollEvent///< Mouse wheel event parameters
    joystickMove     C.sfJoystickMoveEvent    ///< Joystick move event parameters
    joystickButton   C.sfJoystickButtonEvent  ///< Joystick button event parameters
    joystickConnect  C.sfJoystickConnectEvent ///< Joystick (dis)connect event parameters
    touch            C.sfTouchEvent           ///< Touch events parameters
    sensor           C.sfSensorEvent          ///< Sensor event parameters
}
type Event C.sfEvent

//VideoMode.h
struct C.sfVideoMode {
    width  u32 ///< video mode width, in pixels
    height u32 ///< video mode height, in pixels
    bpp    u32 ///< video mode pixel depth, in bits per pixels
}
type VideoMode C.sfVideoMode

//Window.h
pub enum WindowStyle
{
    non          = 0    ///< no border / title bar (this flag and all others are mutually exclusive)
    titlebar     = 1    ///< title bar + fixed border
    resize       = 2    ///< titlebar + resizable border + maximize button
    close        = 4    ///< titlebar + close button
    fullscreen   = 8    ///< fullscreen mode (this flag and all others are mutually exclusive)
    defaultstyle = 16   ///< default window style
}
pub enum ContextAttribute
{
    contextdefault = 0     ///< non-debug, compatibility context (this and the core attribute are mutually exclusive)
    contextcore    = 1 ///< core attribute
    contextdebug   = 4  ///< debug attribute
}

struct C.sfContextSettings
{
    depthbits         u32   ///< bits of the depth buffer
    stencilbits       u32   ///< bits of the stencil buffer
    antialiasinglevel u32   ///< level of antialiasing
    majorversion      u32   ///< major number of the context version to create
    minorversion      u32   ///< minor number of the context version to create
    attributeflags    u32   ///< the attribute flags to create the context with
    srgbcapable      bool  ///< whether the context framebuffer is srgb capable
}
type ContextSettings C.sfContextSettings

[typedef] //Types.h
struct C.sfWindow 
type Window &C.sfWindow
// Construct a new window
pub fn create_win(vmode VideoMode,title string,style WindowStyle,cs ContextSettings) Window{
    return C.sfWindow_create(vmode,title.str,style,&cs)
}
// Destroy a window
pub fn destroy_win(win Window) {
    C.sfWindow_destroy(win)
}
// Close a window and destroy all the attached resources
pub fn close_win(win Window) {
    C.sfWindow_close(win)
}
// Tell whether or not a window is opened
pub fn win_isopen(win Window) bool{
    return C.sfWindow_isOpen(win)
}
// Get the settings of the OpenGL context of a window
pub fn get_settings(win Window) ContextSettings{
    return C.sfWindow_getSettings(win)
}
// Pop the event on top of event queue, if any, and return it
pub fn pollevnet(win Window,ev Event) bool{
    return C.sfWindow_pollEvent(&win,&ev)
}
