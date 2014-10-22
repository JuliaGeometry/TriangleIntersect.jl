[![Build Status](https://travis-ci.org/skariel/TriangleIntersect.jl.svg)](https://travis-ci.org/skariel/TriangleIntersect.jl)
[![Coverage Status](https://img.shields.io/coveralls/skariel/TriangleIntersect.jl.svg)](https://coveralls.io/r/skariel/TriangleIntersect.jl)

# TriangleIntersect

Find if and where a light ray intersects a triangle (in 3D of course). This is optimized for speed.

# Installation

```Julia
Pkg.clone("git://github.com/skariel/TriangleInstersect.jl.git")
```

#Usage
Import and create some points:
```Julia
using TriangleIntersect
a = Point(0,0,0)
b = Point(1,0,0)
c = Point(0,1,0)
```

Create a triangle
```Julia
t = Triangle(b,a,c)
```

Create a ray:
```Julia
r = Ray(Point(0.1,0.1,1), Point(0.1,0.1,-1))
```

Check the intersection:
```Julia
p, i = intersect(r, t)
```
`i` here is a boolean, `true` if there is intersection and `false` if not. `p` is the intersection point.
