import UIKit

/*
 
 Demonstrate drawing using gstate management
 
 */

let size = CGSize(width: 300, height: 100)
let format = UIGraphicsImageRendererFormat()
(format.opaque, format.scale, format.prefersExtendedRange) = (true, 1.0, true)
let renderer = UIGraphicsImageRenderer(size: size, format: format)

let image = renderer.image { context in
    var dest = CGRect(x: 2, y: 2, width: 96, height: 96)
    var oval = UIBezierPath(ovalIn: dest); oval.lineWidth = 4
    UIColor.black.setStroke(); oval.stroke()
    
    // Perform drawing changes in GState block
    context.cgContext.saveGState()
        // gray color applied to context
        UIColor.lightGray.setStroke()
    
        // Draw an oval
        dest.origin.x += 100
        oval = UIBezierPath(ovalIn: dest); oval.lineWidth = 4
        oval.stroke()
    context.cgContext.restoreGState()
    
    // Restored to black, draw an oval
    dest.origin.x += 100
    oval = UIBezierPath(ovalIn: dest); oval.lineWidth = 4
    oval.stroke()
}

image
// image.saveImage()

/*
 
 Draw it again, but with the pushDraw utility this time.
 
 */

func pushDraw(in context: UIGraphicsImageRendererContext,
              applying actions: () -> Void)
{
    context.cgContext.saveGState()
    actions()
    context.cgContext.restoreGState()
}

let image2 = renderer.image { context in
    var dest = CGRect(x: 2, y: 2, width: 96, height: 96)
    var oval = UIBezierPath(ovalIn: dest); oval.lineWidth = 4
    UIColor.black.setStroke(); oval.stroke()
    
    pushDraw(in: context) {
        // gray color applied to context
        UIColor.lightGray.setStroke()
        
        // Draw an oval
        dest.origin.x += 100
        oval = UIBezierPath(ovalIn: dest); oval.lineWidth = 4
        oval.stroke()
    }
    
    // Restored to black, draw an oval
    dest.origin.x += 100
    oval = UIBezierPath(ovalIn: dest); oval.lineWidth = 4
    oval.stroke()
}

image2
