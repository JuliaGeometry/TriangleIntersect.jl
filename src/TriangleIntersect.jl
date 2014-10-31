module TriangleIntersect

export Point, Triangle, Ray, intersect, Intersection, no_intersection

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
/(p::Point, n::Number) = Point(p.x/n, p.y/n, p.z/n)
unitize(p::Point) = p/(p*p)

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
    Ray(a,b) = new(a,unitize(b))
end

immutable Intersection
    ip::Point # intersecting point
    id::Float64 # intersecting distance
    is_intersection::Bool
end

const no_intersection = Intersection(Point(0,0,0), 0.0, false)

function intersect(r::Ray, t::Triangle)
    const denom = t.normal*r.direction
    denom == 0 && return no_intersection
    ri = t.normal*(t.a - r.origin) / denom
    ri <= 0 && return no_intersection
    plane_intersection =  ri * r.direction + r.origin    
    w = plane_intersection - t.a    
    const wv1 = w*t.v1
    const wv2 = w*t.v2
    s_intersection = (t.v1v2*wv2 - t.v2v2*wv1) / t.denom
    s_intersection <= 0 && return no_intersection
    s_intersection >= 1 && return no_intersection
    t_intersection = (t.v1v2*wv1 - t.v1v1*wv2) / t.denom
    t_intersection <= 0 && return no_intersection
    t_intersection >= 1 && return no_intersection
    s_intersection + t_intersection >= 1 && return no_intersection
    Intersection(t.a + s_intersection*t.v1+t_intersection*t.v2, ri, true)
end

end # module
