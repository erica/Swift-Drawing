import UIKit

let image = UIImage(named: "publicdomainman.jpg")!
extension UIImage {
    public func grayscaled() -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let (width, height) = (Int(size.width), Int(size.height))
        
        // Build context: one byte per pixel, no alpha
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue) else { return nil }
        
        // Draw to context
        let destination = CGRect(origin: .zero, size: size)
        context.draw(cgImage, in: destination)
        
        // Return the grayscale image
        guard let imageRef = context.makeImage() else { return nil }
        return UIImage(cgImage: imageRef)
    }
}

image
let grayscale = image.grayscaled()!
// image.saveImage()
// grayscale.saveImage()