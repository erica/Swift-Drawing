import UIKit

var dashes: [CGFloat] = [12, 4, 2]
let drawSize = CGSize(width: 100, height: 100)
let ovalRect = CGRect(origin: .zero, size: drawSize)
    .insetBy(dx: 5, dy: 5)

let path = UIBezierPath(ovalIn: ovalRect)
path.lineWidth = 6
path.setLineDash(&dashes, count: dashes.count, phase: 0)

let image = UIGraphicsImageRenderer(size: drawSize).image {
    context in let bounds = context.format.bounds
    UIColor.white.set(); UIRectFill(bounds);
    UIColor.red.setFill(); UIColor.blue.setStroke()
    path.fill(); path.stroke()
}

image.saveImage()
