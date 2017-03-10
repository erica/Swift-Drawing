import UIKit

let size = CGSize(width: 180, height: 180)
let format = UIGraphicsImageRendererFormat()
(format.opaque, format.scale, format.prefersExtendedRange) = (true, 1.0, true)
let renderer = UIGraphicsImageRenderer(size: size, format: format)

// Draw with fill followed by stroke

let image = renderer.image { context in
    let bounds = context.format.bounds
    let oval = UIBezierPath(ovalIn: bounds.insetBy(dx: 8, dy: 8))
    oval.lineWidth = 8.0
    UIColor.white.setFill(); UIRectFill(bounds)
    UIColor.red.setFill()
    UIColor.blue.setStroke()
    
    oval.fill(); oval.stroke()
}

image
// image.saveImage()
