import UIKit

func pushDraw(in context: UIGraphicsImageRendererContext,
              applying actions: () -> Void)
{
    context.cgContext.saveGState()
    actions()
    context.cgContext.restoreGState()
}


let π = CGFloat(Double.pi)
let size = CGSize(width: 200, height: 200)
let renderer = UIGraphicsImageRenderer(size: size)

// Enable kerning
let attributes: [String: Any] = [
    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0),
    NSForegroundColorAttributeName: UIColor.black,
    NSKernAttributeName: 8,
]

// Textkit layout
let manager = NSLayoutManager()
let container = NSTextContainer(size: CGSize(width: .max, height: .max))
manager.addTextContainer(container)
let attributedString = NSTextStorage(string: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", attributes: attributes)
manager.textStorage = attributedString

let fullWidth = manager.boundingRect(forGlyphRange: NSMakeRange(0, 26), in: container).size.width
let lettersAndSizes = Array(0 ..< 26).lazy
    .map({ NSMakeRange($0, 1) })
    .map({ (attributedString.attributedSubstring(from: $0),
           manager.boundingRect(forGlyphRange: $0, in: container).size) })

var consumedSize: CGFloat = 0

let image = renderer.image { context in
    let bounds = context.format.bounds
    let (centerX, centerY) = (bounds.midX, bounds.midY)
    
    // Start by adjusting the context origin
    // This affects all subsequent operations
    context.cgContext.translateBy(x: centerX, y: centerY)
    
    // Offset by half of the first character
    let firstHalfWidth = lettersAndSizes.first!.1.width / 2.0
    let theta = 2 * π * firstHalfWidth / fullWidth
    context.cgContext.rotate(by: -theta)
    
    // Set the radius to draw at
    let r: CGFloat = 70
    
    
    // Draw each letter proportionally
    for (letter, letterSize) in lettersAndSizes
    {
        let halfWidth = letterSize.width / 2.0
        let halfHeight = letterSize.height / 2.0
        consumedSize = consumedSize + halfWidth;
        defer { consumedSize += halfWidth }
        pushDraw(in: context) {
            // Rotate the context
            let theta = 2 * π * consumedSize / fullWidth
            context.cgContext.rotate(by: theta)
            
            // Translate up to the edge of the radius and
            // move left by half the letter width.
            context.cgContext.translateBy(x: 0, y: -(r + halfHeight))
            let rect = CGRect(origin: CGPoint(x: -halfWidth, y: 0), size: letterSize)
            letter.draw(in: rect)
        }
    }
}

image

image.saveImage()
