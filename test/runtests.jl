using TriangleIntersect
using Base.Test

a = Point(0,0,0)
b = Point(1,0,0)
c = Point(0,1,0)
t = Triangle(a,b,c)
r = Ray(Point(0.1,0.1,1), Point(0.1,0.1,-1))

@test i == intersect(r, t) == Intersection(Point(0.2,0.2,0.0), 1.02, true)

# yeah, more tests are needed :)


