![](about/collage-owl.jpg)

<!--- ------------------------------------------------------- -->
What is OWL?
============

OWL is a convenience/productivity-oriented library on top of OptiX
7.x, and aims at making it easier to write OptiX programs by taking
some of the more arcane arts (like knowing what a Shader Binding Table
is, and how to actually build it), and doing that for the user. For
example, assuming the node graph (ie, the programs, geometries, and
acceleration structures) have already been built, the shader binding
table (SBT) can be built and properly populated by a single call
`owlBuildSBT(context)`.

In addition, OWL also allows for somewhat higher-level abstractions
than native OptiX+CUDA for operations such as creating device buffers,
uploading data, building shader programs and pipelines, building
acceleration structures, etc. 

Fore more details on OWL, please see the following resources:

  
- A recent ["Introducing OWL" blog
  post](https://ingowald.blog/2020/11/08/introducing-owl-a-node-graph-abstraction-layer-on-top-of-optix-7/)
  that gives a high-level motivation/overview what the project is
  about, and where it currently is (though without much detail on how
  OWL actually works)

- For latest code on github: [https://github.com/owl-project/owl](https://github.com/owl-project/owl)

- For a brief (visual) overview over latest samples: [http://owl-project.github.io/Samples.html](http://owl-project.github.io/Samples.html)

- Latest news/updates: [http://owl-project.github.io/News.html](http://owl-project.github.io/News.html)


Key Concepts Supported in OWL
=============================

OWL builds on the following key concepts:

- Buffers (realized via CUDA allocated memory), similar to the old Optix 6 `optix::Buffer` type

    - Buffers can be either device buffers (corresponding to regular
      cudaMalloc'ed memory), host-pinned memory buffers, or managed
      memory buffers.
	  
	- Buffers can be created over all sorts of trivially copyable
      types like FLOAT3, INT, etc, but also over advanced types like
      (CUDA) textures or other buffers.

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
	
    - for user geometries, OWL provides functionality to automate the
	process for computing device-side bounding boxes through bounds
	program (including building of the kernels, allocation of the
	memory, parametrization and executing the kernel, etc).
	
- Creation of Groups and Acceleration Structures

    - OWL abstracts acclerations structures through "groups" built over
    geometries, with each group containing exactly one acceleration
    strcutures over all the geometries in that group:
	
    - `TriangleGeomGroups`: a groupover triangle geometries, hardware
    accelerated where available.
  
    - `UserGeomGroups`: a group over user geometries; in particular,
     will simplify the process of creating the user geometry bounds that go into
	 the BVH build)

    - `InstanceGroups`: a group over instance of other
      groups. 
	
    - building acceleration structures is usually as simple as creating the group,
    and calling `owlGroupBuildAccel(group)`. Refitting and motion blur are supported.

- Instancing: OWL supports instancing through Instance Groups

    - Multi-Level Instancing is explicitly supported by instance groups containing other
  instance groups (see sample `s08-sierpinki` for an example)

- Abstraction/Automatic Creation of Shader Binding Table, Programs, etc

    - owl will automatically put the created groups/instances in the right order,
    allocate memory for the SBT, and create the respective entries.
	
- Multi-Device: OWL Supports multi-device rendering, on both ll and ng layer.

- Parametrization of device-side Geometries, Launch Params, etc, via Variables

	- which variables a device-side object has gets defined by the user; these
	  can then be configured via calls like, e.g., 
	  
    owlParamsSetGroup(myLaunchParams,"world",world")

- support for launch parameters, asynchronous launches, and CUDA interop.


Currently still *Missing* Functionality
=======================================

- OWL currently supports both triangle and user-definable geometry, but
  does not yet support the `Curves` geometry added in OptiX 7.2.
  
- OWL does not yet explicitly expose the denoiser. The OptiX denoiser
  *can* be called directly on the OWL-buffers used by the application,
  but currently still still has to be done manually.
  
  
