import Foundation

// Melkman Algorithm: Convex Hull in O(n)
// Courtesy of http://geomalgorithms.com/a12-_hull-3.html

func isLeft(p0: CGPoint, _ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    return (p1.x - p0.x) * (p2.y - p0.y) - (p2.x - p0.x) * (p1.y - p0.y)
}

func convexHull(points: [CGPoint]) -> [CGPoint] {
    // p = points
    // n = points.count
    
    var d = [CGPoint](count: 2 * points.count + 1, repeatedValue: CGPointZero)
    var bot = points.count - 2
    var top = bot + 3
    
    d[bot] = points[2]
    d[top] = points[2]
    
    if isLeft(points[0], points[1], points[2]) > 0 {
        d[bot+1] = points[0]
        d[bot+2] = points[1]
    } else {
        d[bot+1] = points[1]
        d[bot+2] = points[0]
    }
    
    for i in 3..<points.count {
        if isLeft(d[bot], d[bot+1], points[i]) > 0 && isLeft(d[top-1], d[top], points[i]) > 0 {
            continue
        }
        
        while isLeft(d[bot], d[bot+1], points[i]) <= 0 {
            bot += 1
        }
        bot -= 1
        d[bot] = points[i]
        
        while isLeft(d[top-1], d[top], points[i]) <= 0 {
            top -= 1
        }
        top += 1
        d[top] = points[i]
    }
    
    var hull = [CGPoint]()
    for h in 0...(top-bot) {
        hull.append(d[bot + h])
    }
    
    return hull
}

func distance(a: CGPoint, _ b: CGPoint) -> CGFloat {
    return pow(a.x - b.x, 2) + pow(a.y - b.y, 2)
}

func pushApart(inout points: [CGPoint]) {
    let dst = CGFloat(15)
    let dst2 = dst * dst
    
    for i in 0..<points.count {
        for j in (i+1)..<points.count {
            if distance(points[i], points[j]) < dst2 {
                var hx = points[j].x - points[i].x
                var hy = points[j].y - points[i].y
                let hl = sqrt(hx*hx + hy*hy)
                
                hx /= hl
                hy /= hl
                
                let dif = dst - hl
                hx *= dif
                hy *= dif
                
                points[j].x += hx
                points[j].y += hy
                
                points[i].x -= hx
                points[i].y -= hy
            }
        }
    }
}
