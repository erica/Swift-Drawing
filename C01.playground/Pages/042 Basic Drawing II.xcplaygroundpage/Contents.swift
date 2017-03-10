import UIKit

// Custom renderer format
let format: UIGraphicsImageRendererFormat = {
    $0.opaque = true
    $0.scale = 0
    $0.prefersExtendedRange = true
    return $0
}(UIGraphicsImageRendererFormat())

let size = CGSize(width: 240, height: 180)
let rect = CGRect(origin: .zero, size: size)
let renderer = UIGraphicsImageRenderer(size: size, format: format)
let image = renderer.image { context in
    UIColor.blue.set(); UIRectFill(rect)
    UIColor.red.set(); UIBezierPath(ovalIn: rect).fill()
}
image
// image.saveImage()