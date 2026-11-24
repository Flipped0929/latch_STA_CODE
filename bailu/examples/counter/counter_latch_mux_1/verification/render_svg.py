"""Render xschem's SVG to PNG with the installed system librsvg and Cairo."""
import ctypes as C
import sys
import xml.etree.ElementTree as ET

rsvg = C.CDLL('librsvg-2.so.2')
cairo = C.CDLL('libcairo.so.2')
gobj = C.CDLL('libgobject-2.0.so.0')
rsvg.rsvg_handle_new_from_file.argtypes = [C.c_char_p, C.POINTER(C.c_void_p)]
rsvg.rsvg_handle_new_from_file.restype = C.c_void_p
cairo.cairo_image_surface_create.argtypes = [C.c_int, C.c_int, C.c_int]
cairo.cairo_image_surface_create.restype = C.c_void_p
cairo.cairo_create.argtypes = [C.c_void_p]
cairo.cairo_create.restype = C.c_void_p


class Rect(C.Structure):
    _fields_ = [('x', C.c_double), ('y', C.c_double), ('width', C.c_double), ('height', C.c_double)]


rsvg.rsvg_handle_render_document.argtypes = [C.c_void_p, C.c_void_p, C.POINTER(Rect), C.POINTER(C.c_void_p)]
rsvg.rsvg_handle_render_document.restype = C.c_int
cairo.cairo_surface_write_to_png.argtypes = [C.c_void_p, C.c_char_p]
cairo.cairo_surface_write_to_png.restype = C.c_int
cairo.cairo_destroy.argtypes = [C.c_void_p]
cairo.cairo_surface_destroy.argtypes = [C.c_void_p]
gobj.g_object_unref.argtypes = [C.c_void_p]

source, target = sys.argv[1:]
svg = ET.parse(source).getroot()
width, height = int(svg.attrib['width']), int(svg.attrib['height'])
error = C.c_void_p()
handle = rsvg.rsvg_handle_new_from_file(source.encode(), C.byref(error))
assert handle and not error.value, 'SVG load failed'
surface = cairo.cairo_image_surface_create(0, width, height)
context = cairo.cairo_create(surface)
try:
    viewport = Rect(0, 0, width, height)
    assert rsvg.rsvg_handle_render_document(handle, context, C.byref(viewport), C.byref(error)) and not error.value
    assert cairo.cairo_surface_write_to_png(surface, target.encode()) == 0
finally:
    cairo.cairo_destroy(context)
    cairo.cairo_surface_destroy(surface)
    gobj.g_object_unref(handle)
print(f'Rendered {target} ({width} x {height}).')
