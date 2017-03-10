import UIKit

// Draw onto a Core Graphics context with UIKit calls
public func imageExample(size: CGSize) -> UIImage? {
    let bounds = CGRect(origin: .zero, size: size)
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let (width, height) = (Int(size.width), Int(size.height))
    
    // Build Core Graphics ARGB context
    guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else { return nil }
    
    // Allow the Core Graphics context to
    // be used by UIKit
    UIGraphicsPushContext(context); defer { UIGraphicsPopContext() }
    
    // Draw to context using UIKit calls
    UIColor.blue.set(); UIRectFill(bounds)
    let oval = UIBezierPath(ovalIn: bounds)
    UIColor.red.set(); oval.fill()
    
    // Fetch the image from the context
    guard let imageRef = context.makeImage() else { return nil }
    return UIImage(cgImage: imageRef)
}

let image = imageExample(size: CGSize(width: 300, height: 200))
// image?.saveImage()

// Draw onto a Core Graphics context with CG calls
public func cgImageExample(size: CGSize) -> UIImage? {
    let bounds = CGRect(origin: .zero, size: size)
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let (width, height) = (Int(size.width), Int(size.height))
    
    // Build Core Graphics ARGB context
    guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else { return nil }
    
    // Draw to context using Core Graphics calls
    context.setFillColor(UIColor.blue.cgColor)
    context.fill(bounds)
    context.setFillColor(UIColor.red.cgColor)
    context.fillEllipse(in: bounds)

    // Fetch the image from the context
    guard let imageRef = context.makeImage() else { return nil }
    return UIImage(cgImage: imageRef)
}

let image2 = cgImageExample(size: CGSize(width: 300, height: 200))


// Draw onto a UIKit context with UIKit calls
public func uiImageExample(size: CGSize) -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { context in
        let bounds = context.format.bounds

        // Draw to context using UIKit calls
        UIColor.blue.set(); UIRectFill(bounds)
        let oval = UIBezierPath(ovalIn: bounds)
        UIColor.red.set(); oval.fill()
    }
}

let image3 = uiImageExample(size: CGSize(width: 300, height: 200))
