//CSFML_WINDOW
module sf

#flag windows -I sf/sfml/include
#flag windows -I sf/sfml/include/SFML
#flag windows -L sf/sfml/lib

#flag windows -l csfml-window

#include "Window.h"
//Clipboard.h
pub fn get_clipboard() string
{
	return tos3(C.sfClipboard_getString())
}
pub fn set_clipboard(text string) {
	C.sfClipboard_setString(text.toc())
}

//Context.h
[typedef]
struct C.sfContext
type Context C.sfContext

pub fn create_context() &Context {
	return C.sfContext_create()
}
pub fn destory_context(ctx &Context){
	C.sfContext_destroy(ctx)
}
pub fn active_context(ctx &Context,active bool) {
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
pub fn destory_cursor(cursor Cursor) {
    C.sfCursor_destroy(cursor)
}
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
type ContextSettings &C.sfContextSettings

[typedef]
struct C.sfWindow
type Window &C.sfWindow

pub fn create_window(vmode VideoMode,title string,style WindowStyle,cs ContextSettings) Window{
    return C.sfWindow_create(vmode,title.toc(),style,cs)
}