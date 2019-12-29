![](about/banner.jpg)

<!--- ------------------------------------------------------- -->
What is OWL?
============

OWL is a OptiX 7 based library that aims at providing some of the
convenience of OptiX 6's Node Graph API on top of OptiX 7. This aims
at making it easier to port existing OptiX 6-style applications over
to OptiX 7, and, in particular, to make it easier to get started with
OptiX 7 even without having a full grasp of things like Shader Binding
Tables, Multi-GPU rendering, etc.

OWL is still in early stages, which means that it as yet lacks many of
the features that OptiX 6 offered, and in particular, that many things
are still changing rather rapidly; however, it already contains
several working mini-samples, so at the very least should allow to
serve as a "show-and-tell" example of how to set up a OptiX 7
pipeline, how to build acceleration structures, how to do things like
compaction, setting up an SBT, etc.

For a (very) rough idea of how the node graph API works, see
  [this brief walk-through through the `ng05-rtow` sample](ng-api-overview.html).


Key links
=========

- For latest code on github: [https://github.com/owl-project/owl](https://github.com/owl-project/owl)

- For a brief (visual) overview over latest samples: [http://owl-project.github.io/Samples.html](http://owl-project.github.io/Samples.html)

- Latest news/updates: [http://owl-project.github.io/News.html](http://owl-project.github.io/News.html)


Currently Already Supported Functionality
=========================================

- Buffers (realized via CUDA allocated memory), similar to the old Optix 6 `optix::Buffer` type

- Abstraction for *geometries* and *geometry types* (i.e., shapes that
  can be intersected with a ray)
  
    - geometry *types* define the optix programs (closesthit, anyhit,
    bounds, etc) that run on the given geometry, as well as the *type*
    of data they run on
	
    - *geometries* are specific instances of a given geometry type
    (not to be confused with a "Instance" object), which is similar
	to the original Optix 6 `optix::GeometryInstance` type.

    - OWL explicitly supports both (hardware-accelerated) triangle geometry types
    (specified through index and vertex buffers) as well as user geometry types
	(that use intersection programs and bounds programs)
	
    - for user geometries, OWL provides functionality to automate most
    of the process for computing device-side bounding boxes through bounds program
	(including building of the kernels, allocation of the memory, parametrization
	and executing the kernel, etc).
	
- Creation of Groups and Acceleration Structures

    - OWL abstracts acclerations structures through "groups" built over
    geometries, with each group containing exactly one acceleration
    strcutures over all the geometries in that group:
	
    - `TriangleGeomGroups`: a groupover triangle geometries, hardware
    accelerated where available.
  
    - `UserGeomGroups`: a group over user geometries; in particular,
     will simplify the process of creating the user geometry bounds that go into
	 the BVH build)

    - `InstanceGroups`: a group over instance of other groups.
	
    - building acceleration structures is usually as simple as creating the group,
    and calling `lloAccelBuild` (ll layer) resp owlAccelBuild (ng layer)

- Instancing: OWL supports instancing through Instance Groups

    - Multi-Level Instancing is explicitly supported by instance groups containing other
  instance groups (see sample `s08-sierpinki` for an example)

- Abstraction/Automatic Creation of Shader Binding Table 

    - owl will automatically put the created groups/instances in the right order,
    allocate memory for the SBT, and create the respective entries.
	
- Multi-Device: OWL Supports multi-device rendering, on both ll and ng layer.

Currently still *Missing* Functionality
=======================================

- Currently support only *building* geometries and acceleration structures,
  but did not yet work on changing/*re-*building either geometries
  or accleleration structures.
  
- Error handling and sanity checking is still minimal. In particular
  the ll layer contains a lot of assertions for sanity-checking, but
  those will obviously work only in debug mode.
  
- Device-side API is still minimalistic, and not yet

- "LaunchParams" are not yet supported. Currently best way of passing
parameters to a ray gen program is through that program's
