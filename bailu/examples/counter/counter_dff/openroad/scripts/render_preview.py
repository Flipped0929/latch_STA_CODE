#!/usr/bin/env python3
"""Rasterize the DEF preview using the existing system librsvg/cairo libraries."""
import ctypes as C
import os
import tempfile
from pathlib import Path

root = Path(__file__).resolve().parents[1]
cache_dir = Path(tempfile.gettempdir()) / 'counter_sky130_fontcache'
(cache_dir / 'fontconfig').mkdir(parents=True, exist_ok=True)
os.environ['XDG_CACHE_HOME'] = str(cache_dir)
svg = C.CDLL('librsvg-2.so.2')
cairo = C.CDLL('libcairo.so.2')
gobj = C.CDLL('libgobject-2.0.so.0')
svg.rsvg_handle_new_from_file.argtypes = [C.c_char_p, C.c_void_p]
svg.rsvg_handle_new_from_file.restype = C.c_void_p
svg.rsvg_handle_render_cairo.argtypes = [C.c_void_p, C.c_void_p]
svg.rsvg_handle_render_cairo.restype = C.c_int
cairo.cairo_image_surface_create.argtypes = [C.c_int, C.c_int, C.c_int]
cairo.cairo_image_surface_create.restype = C.c_void_p
cairo.cairo_create.argtypes = [C.c_void_p]
cairo.cairo_create.restype = C.c_void_p
cairo.cairo_surface_write_to_png.argtypes = [C.c_void_p, C.c_char_p]
cairo.cairo_surface_write_to_png.restype = C.c_int
cairo.cairo_destroy.argtypes = [C.c_void_p]
cairo.cairo_surface_destroy.argtypes = [C.c_void_p]
gobj.g_object_unref.argtypes = [C.c_void_p]
handle = svg.rsvg_handle_new_from_file(str(root / 'results/layout_preview.svg').encode(), None)
assert handle
surface = cairo.cairo_image_surface_create(0, 920, 760)
context = cairo.cairo_create(surface)
try:
    assert svg.rsvg_handle_render_cairo(handle, context)
    assert cairo.cairo_surface_write_to_png(surface, str(root / 'results/layout_preview.png').encode()) == 0
finally:
    cairo.cairo_destroy(context)
    cairo.cairo_surface_destroy(surface)
    gobj.g_object_unref(handle)
print('Rendered layout_preview.png')
