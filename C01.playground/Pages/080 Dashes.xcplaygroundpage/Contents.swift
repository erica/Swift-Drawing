import UIKit

let size = CGSize(width: 600, height: 100)
let renderer = UIGraphicsImageRenderer(size: size)
let π = CGFloat(Double.pi)

let image = renderer.image { context in
    
    let bounds = context.format.bounds
    UIColor.white.set(); UIRectFill(bounds);
    UIColor.red.setFill(); UIColor.blue.setStroke()
    
    let dashes: [[CGFloat]] = [
        [40, 5], [40, 5],
        [π, π, 6 * π, π], [π, π, 6 * π, π],
        [π, π], [π, π],
        ]
    let phases: [CGFloat] = [0, 22.5, 0, 22.5, 0, π / 2]
    
    let size = CGSize(width: 90, height: 90)
    for (idx, offset) in stride(from: 0 as CGFloat, to: 600, by: 100).enumerated() {
        let origin = CGPoint(x: offset + 5, y: 5)
        let path = UIBezierPath(ovalIn: CGRect(origin: origin, size: size))
        path.lineWidth = 6
        var dashPattern = dashes[idx]
        path.setLineDash(&dashPattern, count: dashPattern.count, phase: phases[idx])
        path.fill(); path.stroke()
    }
}

image
// image.saveImage()
