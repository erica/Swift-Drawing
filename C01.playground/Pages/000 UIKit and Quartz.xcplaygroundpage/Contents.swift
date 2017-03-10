import UIKit

// Build an image renderer
let size = CGSize(width: 200, height: 100)
let format = UIGraphicsImageRendererFormat()
print(format.opaque, format.scale, format.prefersExtendedRange)
format.opaque = true // no alpha value
format.scale = 0.0 // native scale
format.prefersExtendedRange = true // wide colors
let renderer = UIGraphicsImageRenderer(size: size, format: format)

// Create an image with the renderer
let image = renderer.image { context in
    
    // Subdivide bounds
    let bounds = context.format.bounds
    let rects = bounds.divided(atDistance: bounds.size.width / 2.0, from: .minXEdge)
    let insetRects = [rects.0, rects.1].map({ $0.insetBy(dx: 4, dy: 4) })

    // Paint background
    UIColor.white.set(); UIRectFill(bounds);
    
    // Prepare to draw
    UIColor.black.set()
    
    // Draw an oval in UIKit
    let bezierPath = UIBezierPath(ovalIn: insetRects[0])
    bezierPath.lineWidth = 3
    bezierPath.stroke()
    
    // Fill an oval in Quartz
    context.cgContext.fillEllipse(in: insetRects[1])
}

image
// image.saveImage()
