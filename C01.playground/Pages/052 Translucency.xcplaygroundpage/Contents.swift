import UIKit

// Create renderer
let size = CGSize(width: 300, height: 180)
let renderer = UIGraphicsImageRenderer(size: size)

// Split bounds
let bounds = CGRect(origin: .zero, size: size)
let width = bounds.size.width
let rects1 = bounds.divided(atDistance: 0.6 * width, from: .maxXEdge)
let rects2 = bounds.divided(atDistance: 0.6 * width, from: .minXEdge)

// Build two ovals
let oval1 = UIBezierPath(ovalIn: rects1.0)
let oval2 = UIBezierPath(ovalIn: rects2.0)


let image1 = renderer.image { context in
    // Draw background
    UIColor.white.set(); UIRectFill(bounds)
    
    // Paint with orange
    UIColor.orange.set(); oval1.fill()
    
    // Paint with solid green
    UIColor.green.set(); oval2.fill()
}

let image2 = renderer.image { context in
    // Draw background
    UIColor.white.set(); UIRectFill(bounds)

    // Paint with orange
    UIColor.orange.set(); oval1.fill()
    
    // Paint with partially translucent green
    UIColor.green.withAlphaComponent(0.75).set(); oval2.fill()
}

image1
image2
//image1.saveImage()
//image2.saveImage()

