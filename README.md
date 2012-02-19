King's Gambit
=============

King's Gambit is a 3D printable chess set inspired by the classic Staunton design, written in OpenSCAD.

In an [announcement post](http://iamwil.posterous.com/designing-kings-gambit-and-using-openscad) on my blog, I give some details and some pictures about King's Gambit. 

Print it out
------------

In order to print out the chess set, you'll need a 3D printer, like the [Ultimaker](http://blog.ultimaker.com/), [Makerbot](http://makerbot.com), or [Prusa Mendel](http://www.makergear.com/products/3d-printers).

To get files to print, you need to "compile" the *.scad files into *.stl files. You can use [OpenSCAD](http://openscad.org) to compile and render using CGAL (push F6). Then, you'll be able to export the model as an STL file. Save it to the "print" directory.

Then load the STL files into using the software that your printer uses to print out objects, and print out each one!

Bill of Materials
-----------------

Here are the pieces that you need to print out for each:

Number, Color, Part

- 8, black, pawn.scad
- 2, black, rook.scad
- 2, black, knight.scad
- 2, black, bishop.scad
- 1, black, queen.scad
- 1, black, king.scad
- 8, white, pawn.scad
- 2, white, rook.scad
- 2, white, knight.scad
- 2, white, bishop.scad
- 1, white, queen.scad
- 1, white, king.scad

If you have a printer with a larger build area, you can simply print out main.scad once for black and once for white.

Parametric settings
-------------------

All the pieces are written to be parametric, as every piece is a function of the base radius. If you'd like to change the size of a piece, simply change its base radius.

The king piece is 100mm tall. [According to the US Chess Federation guidelines, the king piece should be between 85mm and 105mm](http://en.wikipedia.org/wiki/Chess_piece#Chess_sets). However, I've not yet made sure all other pieces fit the guideline.

All the pieces start with a piece_body(), and then build from there. The pawn, bishop, king, and queen use a neck() with collars. Then each one will have specialized heads that are within each module itself.

The knight is uniquely different from all other pieces. Currently, it uses two *.svg files exported to *.dxf. One is the knight face, and the other is the knight profile. The *.dxf files are imported, and extruded into a 3D shape, and then intersected. Eventually, I think I will abandon this method and use spheres and hulls instead to make a more organic shape, though it will take longer to render.

