import UIKit

let view = UIView()
view.layer.backgroundColor = UIColor.white.cgColor

let myCGColor = UIColor.white.cgColor
let color = UIColor(cgColor: myCGColor)

let size = CGSize(width: 400, height: 50)
let renderer = UIGraphicsImageRenderer(size: size)

let image = renderer.image { context in
    let bounds = context.format.bounds
    for amount in stride(from: 1.0 as CGFloat, to: 0.0, by: -0.1) {
        // Select a color
        let color = UIColor(hue: amount, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        // Paint the entire rectangle, cutting off a bit more
        // from the right each time, so successively smaller
        // rectangles are painted
        let rects = bounds.divided(atDistance: amount * bounds.size.width, from: .maxXEdge)
        color.set(); UIRectFill(rects.0)
    }
}

image
// image.saveImage()

