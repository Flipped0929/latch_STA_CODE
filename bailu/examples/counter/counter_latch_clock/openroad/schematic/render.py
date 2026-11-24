"""Rasterize xschem's native SVG export and create detail views for QA."""
from pathlib import Path
import gi
gi.require_version('Rsvg', '2.0')
from gi.repository import Rsvg
import cairo
from PIL import Image

root = Path(__file__).resolve().parents[2]
svg = root / 'counter_routed.svg'
handle = Rsvg.Handle.new_from_file(str(svg))
width, height = 4200, 3300
surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, width, height)
context = cairo.Context(surface)
context.set_source_rgb(1, 1, 1)
context.paint()
viewport = Rsvg.Rectangle()
viewport.x, viewport.y, viewport.width, viewport.height = 0, 0, width, height
handle.render_document(context, viewport)
surface.write_to_png(str(root / 'counter_routed.png'))
image = Image.open(root / 'counter_routed.png')
sx, sy = width/3440, height/2700
for name, box in {
    'clock_detail': (80, 210, 3350, 900),
    'phi1_detail': (80, 210, 1830, 900),
    'phi2_detail': (1880, 210, 3350, 900),
    'data_detail': (90, 1650, 3350, 2030),
}.items():
    pixels = tuple(round(value*(sx if i%2 == 0 else sy)) for i, value in enumerate(box))
    image.crop(pixels).save(root / 'openroad/schematic' / (name + '.png'))
print('Rendered counter_routed.png and clock/data detail images from xschem SVG.')
