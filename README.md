[![Build Status](https://travis-ci.org/JuliaGeometry/TriangleIntersect.jl.svg?branch=master)](https://travis-ci.org/JuliaGeometry/TriangleIntersect.jl)
[![Coverage Status](https://coveralls.io/repos/JuliaGeometry/TriangleIntersect.jl/badge.svg?branch=master)](https://coveralls.io/r/JuliaGeometry/TriangleIntersect.jl?branch=master)

# TriangleIntersect

Find if and where a light ray intersects a triangle (in 3D of course). This is optimized for speed. See nice general explanation [here](http://geomalgorithms.com/a06-_intersect-2.html)

# Installation

```Julia
Pkg.clone("git://github.com/JuliaGeometry/TriangleIntersect.jl.git")
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

Cast a ray:
```Julia
r = Ray(Point(0.1,0.1,1), Point(0.1,0.1,-1))
```

Check the intersection:
```Julia
intersect(r, t) # -> Intersection(Point(0.2,0.2,0.0),1.02,true)
```
The `Intersection` type is simply defined as:
```Julia
immutable Intersection
    ip::Point # intersecting point
    id::Float64 # intersecting distance
    is_intersection::Bool
end
```
