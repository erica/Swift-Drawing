import UIKit

let (width, height) = (200.0 as CGFloat, 150.0 as CGFloat)
let size = CGSize(width: width, height: height)
let format = UIGraphicsImageRendererFormat()
(format.opaque, format.scale, format.prefersExtendedRange) = (true, 1.0, true)
let renderer = UIGraphicsImageRenderer(size: size, format: format)

/*
 
 Both UIKit and Quartz now use the same user-coordinate system. It's uncommon to have to flip coordinates to properly draw, especially when using the latest UIKit graphics renderer.
 
 */

// Example showing that both rects are placed in user coordinate space
// Until recently, they would not have been well behaved
let image = renderer.image { context in
    let rect = CGRect(x: 20, y: 20, width: 20, height: 20)
    
    // Background
    UIColor.white.set(); UIRectFill(context.format.bounds)
    
    // UIKit drawing
    UIColor.black.set(); UIRectFill(rect)
    
    // Quartz drawing
    context.cgContext.setFillColor(UIColor.lightGray.cgColor)
    context.cgContext.addPath(UIBezierPath(rect: rect).cgPath)
    context.cgContext.fillPath()
}
image

/*
 
 However, you do have to flip coordinates for rendering Bezier paths
 
 */
let q = UIBezierPath(character: "Q", size: 128.0)!
let dx = (width - q.bounds.size.width) / 2.0
let dy = (height - q.bounds.size.height) / 2.0
q.apply(CGAffineTransform(
    translationX: -q.bounds.origin.x,
    y: -q.bounds.origin.y))
q.apply(CGAffineTransform(translationX: dx, y: dy))

let image2 = renderer.image { context in
    UIColor.white.set(); UIRectFill(context.format.bounds)
    UIColor.black.set(); q.fill()
}

image2
// image2.saveImage()

/*
 
 Introducing `drawFlipped`, which makes the drawing well behaved and
 hides the details of the context transformation matrix (CTM) 
 manipulation
 
 */

func pushDraw(in context: UIGraphicsImageRendererContext,
              applying actions: () -> Void)
{
    context.cgContext.saveGState()
    actions()
    context.cgContext.restoreGState()
}


func drawFlipped(in context: UIGraphicsImageRendererContext,
                 applying actions: () -> Void)
{
    pushDraw(in: context) {
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(
            x: 0, y: -context.format.bounds.size.height)
        context.cgContext.concatenate(transform)
        actions()
    }
}


let image3 = renderer.image { context in
    UIColor.white.set(); UIRectFill(context.format.bounds)
    drawFlipped(in: context) {
        UIColor.black.set(); q.fill()
    }
}

image3
// image3.saveImage()


