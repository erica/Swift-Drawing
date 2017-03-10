import UIKit

let size = CGSize(width: 240, height: 180)
let rect = CGRect(origin: .zero, size: size)
let renderer = UIGraphicsImageRenderer(size: size)
let image = renderer.image { context in
    UIColor.blue.set(); UIRectFill(rect)
    UIColor.red.set(); UIBezierPath(ovalIn: rect).fill()
}
image
// image.saveImage()

extension CGColor {
    public var uiColor: UIColor {
        return UIColor(cgColor: self)
    }
}

let cg = UIColor.red.cgColor
let red = cg.uiColor