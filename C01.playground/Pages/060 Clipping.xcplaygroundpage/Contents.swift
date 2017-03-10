import UIKit

// All this is to build a large Bezier path of the letter "Q"
// Then size and zero the path. You can ignore this. The code
// that creates the path is in the page's Sources folder.
let q = UIBezierPath(character: "Q", size: 128.0)!
let (width, height) = (200.0 as CGFloat, 150.0 as CGFloat)
let dx = (width - q.bounds.size.width) / 2.0
let dy = (height - q.bounds.size.height) / 2.0
q.apply(CGAffineTransform(translationX: -q.bounds.origin.x, y: -q.bounds.origin.y))
q.apply(CGAffineTransform(translationX: dx, y: dy))

// Pick up here, now there's a "Q" to work with.
// Keep in mind that this `random` function is
// not the one from the standard C library

let size = CGSize(width: width, height: height)
let renderer = UIGraphicsImageRenderer(size: size)
let random = Random.uniform

// Here's the actual example!
// Use a Bezier path to clip the context, then paint lots
// and lots and lots of small colored circles

let image = renderer.image { context in
    let bounds = context.format.bounds
    
    // Background
    UIColor.white.set(); UIRectFill(context.format.bounds)
    
    // Flip the coordinate system
    drawFlipped(in: context) {
        
        // Add clip, which sets the insides of "Q"
        // as the only available drawing area.
        q.addClip()
        
        // Draw lots of circles, hopefully covering the
        // entire path. Increase the number (you shouldn't
        // have to) if you need more paint applied.
        
        for _ in 1 ... 500 {
            let color = UIColor(red: random(), green: random(), blue: random(), alpha: 1.0)
            let origin = CGPoint(x: random() * 150, y: random() * 150)
            let size = CGSize(width: random() * 50, height: random() * 50)
            let oval = UIBezierPath(ovalIn: CGRect(origin: origin, size: size))
            color.set(); oval.fill()
        }
    }
}

image
// image.saveImage()
