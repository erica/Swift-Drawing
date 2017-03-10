import UIKit


public func colorWheel(
    sized side: CGFloat = 240,
    border: Bool = false,
    fill: Bool = true) -> UIImage
{
    // Initialize Renderer
    let size = CGSize(width: side, height: side)
    let format = UIGraphicsImageRendererFormat()
    (format.opaque, format.scale, format.prefersExtendedRange) = (true, 0.0, true)
    let renderer = UIGraphicsImageRenderer(size: size, format: format)
    
    // Build color wheel image
    return renderer.image { context in
        let bounds = context.format.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let width = side / 14
        let π = CGFloat(Double.pi)

        // Optional background (otherwise clear)
        if fill { UIColor.black.set(); UIRectFill(bounds) }
        
        // Draw 6 rings
        (1 ... 6).forEach {
            let idx = CGFloat($0)
            let radius = width * idx
            let saturation = idx / 6
            var path: UIBezierPath
            
            for theta in stride(from: 0.0 as CGFloat, to: 2 * π, by: π / 6) {
                let hue = theta / (2 * π)
                let color = UIColor(hue: hue, saturation: saturation, brightness: 1, alpha: 1)
                path = UIBezierPath(arcCenter: center, radius: radius, startAngle: theta, endAngle: theta + π / 6, clockwise: true)
                path.lineWidth = width
                color.set(); path.stroke()
            }
            
            if border {
                path = UIBezierPath(arcCenter: center, radius: side / 2 - side / 28, startAngle: 0, endAngle: 2 * π, clockwise: true)
                path.lineWidth = 4
                UIColor.black.set(); path.stroke()
            }
        }
    }
}

let image = colorWheel()
image.saveImage()
