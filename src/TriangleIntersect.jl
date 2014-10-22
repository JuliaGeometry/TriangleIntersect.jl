module TriangleIntersect

export Point, Triangle, Ray, intersect

immutable Point
    x::Float64
    y::Float64
    z::Float64
end

*(p::Point, n::Number) = Point(p.x*n, p.y*n, p.z*n)
*(n::Number, p::Point) = p*n
*(p1::Point, p2::Point) = p1.x*p2.x+p1.y*p2.y+p1.z*p2.z
-(p1::Point, p2::Point) = Point(p1.x-p2.x, p1.y-p2.y, p1.z-p2.z)
+(p1::Point, p2::Point) = Point(p1.x+p2.x, p1.y+p2.y, p1.z+p2.z)
cross(p1::Point, p2::Point) = Point(p1.y*p2.z-p1.z*p2.y, -p1.x*p2.z+p1.z*p2.x, p1.x*p2.y-p1.y*p2.x)

immutable Triangle
    a::Point
    v1::Point
    v2::Point
    normal::Point
    v1v1::Float64
    v2v2::Float64
    v1v2::Float64
    denom::Float64
    function Triangle(a::Point, b::Point, c::Point)
        const v1 = b-a
        const v2 = c-a
        const normal = cross(v1, v2)
        const v1v1 = v1*v1
        const v2v2 = v2*v2
        const v1v2 = v1*v2
        const denom = v1v2*v1v2 - v1v1*v2v2
        new(a, v1, v2, normal, v1v1, v2v2, v1v2, denom)
    end
end

immutable Ray
    origin::Point
    direction::Point
end

function intersect(r::Ray, t::Triangle)
    const denom = t.normal*r.direction
    denom == 0 && return (Point(0,0,0), false)
    ri = t.normal*(t.a - r.origin) / denom
    ri <= 0 && return (Point(0,0,0), false)
    plane_intersection =  ri * r.direction + r.origin    
    w = plane_intersection - t.a    
    const wv1 = w*t.v1
    const wv2 = w*t.v2
    s_intersection = (t.v1v2*wv2 - t.v2v2*wv1) / t.denom
    s_intersection <= 0 && return (Point(0,0,0), false)
    s_intersection >= 1 && return (Point(0,0,0), false)
    t_intersection = (t.v1v2*wv1 - t.v1v1*wv2) / t.denom
    t_intersection <= 0 && return (Point(0,0,0), false)
    t_intersection >= 1 && return (Point(0,0,0), false)
    s_intersection + t_intersection >= 1 && return (Point(0,0,0), false)
    (t.a + s_intersection*t.v1+t_intersection*t.v2, true)
end

end # module
