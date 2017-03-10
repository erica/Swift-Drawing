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
let attributes = [
    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0),
    NSForegroundColorAttributeName: UIColor.black
]

// Convert characters to attributed strings and measure them
let characters = CharacterSet.uppercaseEnglishLetterSet.members
let letters = characters.lazy
    .map({ String($0) })
    .map({ NSAttributedString(string: $0, attributes: attributes) })
let letterSizes = letters.map({ $0.size().width })

// Calculate the full extent
let fullSize = letterSizes.reduce(0 as CGFloat, +)
var consumedSize: CGFloat = 0

let image = renderer.image { context in
    let bounds = context.format.bounds
    let (centerX, centerY) = (bounds.midX, bounds.midY)
    
    // Start by adjusting the context origin
    // This affects all subsequent operations
    context.cgContext.translateBy(x: centerX, y: centerY)
    
    // Offset by half of the first character
    let firstHalfSize = letterSizes.first! / 2.0
    let theta = 2 * π * firstHalfSize / fullSize
    context.cgContext.rotate(by: -theta)
    
    // Set the radius to draw at
    let r: CGFloat = 70
    
    // Draw each letter proportionally
    for (letter, letterSize) in zip(letters, letterSizes)
    {
        let halfWidth = letterSize / 2.0
        consumedSize = consumedSize + halfWidth;
            defer { consumedSize += halfWidth }
        pushDraw(in: context) {
            // Rotate the context
            let theta = 2 * π * consumedSize / fullSize
            context.cgContext.rotate(by: theta)
            
            // Translate up to the edge of the radius and
            // move left by half the letter width.
            context.cgContext.translateBy(x: -halfWidth, y: -r)
            letter.draw(at: .zero)
        }
    }
}

image
image.saveImage()
