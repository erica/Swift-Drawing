import UIKit

// Build an image renderer
let size = CGSize(width: 200, height: 100)

extension UIImage {
    static func draw(to size: CGSize, actions: (_ context: CGContext) -> Void ) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        defer { UIGraphicsEndImageContext() }
        actions(context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}



// Create an image with the renderer
let image = UIImage.draw(to: size) { context in
    
    // Subdivide bounds
    let bounds = CGRect(origin: .zero, size: size)
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
    context.fillEllipse(in: insetRects[1])
}

image
// image.saveImage()
