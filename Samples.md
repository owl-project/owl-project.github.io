# Samples

OWL comes with a set of successively more complex samples to aid in
understanding how to use the OWL API.



<!-- ======================================================= -->
## `ll08-sierpinski`

The latest sample, demonstrating multi-level instancing:

- One geometry that contains exactly one pyramid

- N levels of instances, each of which creates four shifted and scaled
  instances of the previous level

- Number of levels configurable via command-line, via `--num-levels <N>`

![PNG file produced by this sample](samples/ll08-sierpinski.png.jpg){.samplepic}




<!-- ======================================================= -->
## `ll07-groupOfGroups`

![PNG file produced by this sample](samples/ll07-groupOfGroups.png.jpg){.samplepic}






<!-- ======================================================= -->
## `ll06-rtow-mixedGeometries`

- Extends `ll05` by replacing some of the spheres with boxes

- Boxes are realized as triangle meshes, and organized in
  three different geometries (again, once per material).

- To support both boxes and user geometries this sample is the first
  to use two *different* groups (one triangle group, one user geom
  group)

- In this sample, device-code traces into the two different groups
  sequentially, then picks the closer of the two hitpoints

![PNG file produced by this sample](samples/ll06-rtow-mixedGeometries.png.jpg){.samplepic}





<!-- ======================================================= -->
## `ll05-rtow`

- The first-ever "real" example that re-implements Ingo Wald
  original OptiX-6 based "Ray Tracing in one Weekend" example
  with OWL.

- Three different CH programs - one each for Lambertian, Metal, and Dielectric.

- Spheres are organized in three different geometry groups (one per
  material type), each of which has multiple spheres.

- Material parameters are stored per-material, in a buffer per each
  geometry (i.e., the Lambertian spheres geom has a buffer of Lambertian
  material data, etc).

![PNG file produced by this sample](samples/ll05-rtow.png.jpg){.samplepic}




<!-- ======================================================= -->
## `ll04-userGeometry-boundsProg`

- Similar to ll03, except that bounds are computed via a bounding box *program*

- Bounds program specified in the device-program, and added to the
  user geometry type, then automatically run on device (on
  owl-allocated memory) when the accel structure needs rebuild (same
  as OptiX 6 bounds program).
  
![PNG file produced by this sample](samples/ll04-userGeometry-boundsProg.png.jpg){.samplepic}





<!-- ======================================================= -->
## `ll03-userGeometry-boundsBuffer`

- Replaces the triangle meshes in ll02 with user geometry

- User geometry uses an intersection program to implement a sphere shape

- in this sample, bounding box information for user geoms is passed
  via a (host-supplied) buffer of precomputed bounding boxes

![PNG file produced by this sample](samples/ll03-userGeometry-boundsBuffer.png.jpg){.samplepic}







<!-- ======================================================= -->
## `ll02-multipleTriangleGroups`

- Replaces single box with eight different ones

- Each box is its own triangle mesh, with its own SBT entry

- SBT entry stores the material data, closest-hit shader pulls this to
shade boxes with different colors.

- Still one accel that contains all eight meshes

![PNG file produced by this sample](samples/ll02-multipleTriangleGroups.png.jpg){.samplepic}










<!-- ======================================================= -->
## `ll01-simpleTriangles`

This was the very first sample ever implemented for OWL (at a time
when OWL could do exactly this sample, and nothing else).

Key features:

- a single triangle mesh (the box) with a single SBT entry

- a single bottom-level acceleration structure

- a minimalistic miss program that uses launch index to compute the
  black-and-red-squares pattern

- a closest-hit program that computes geometry normal and dot N-dot-D shading.


![PNG file produced by this sample](samples/ll01-simpleTriangles.png.jpg){.samplepic}
