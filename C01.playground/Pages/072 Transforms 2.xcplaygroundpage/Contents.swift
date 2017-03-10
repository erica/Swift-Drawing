import UIKit

func pushDraw(in context: UIGraphicsImageRendererContext,
                 applying actions: () -> Void)
{
    context.cgContext.saveGState()
    actions()
    context.cgContext.restoreGState()
}

let size = CGSize(width: 200, height: 200)
let renderer = UIGraphicsImageRenderer(size: size)
let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12.0), NSForegroundColorAttributeName: UIColor.black]
let π = CGFloat(Double.pi)

// Convert characters to attributed strings and measure them
let characters = CharacterSet.uppercaseEnglishLetterSet.members
let letters = characters.lazy
    .map({ String($0) })
    .map({ NSAttributedString(string: $0, attributes: attributes) })
let letterSizes = letters.map({ $0.size().width })

let image = renderer.image { context in
    let bounds = context.format.bounds
    let (centerX, centerY) = (bounds.midX, bounds.midY)
    
    // Start by adjusting the context origin
    // This affects all subsequent operations
    context.cgContext.translateBy(x: centerX, y: centerY)

    let r: CGFloat = 70
    
    for (idx, (letter, letterSize)) in
        zip(letters, letterSizes).enumerated()
    {
        pushDraw(in: context) {
            // Rotate the context
            let theta = CGFloat(idx) * (2 * π) / 26.0
            context.cgContext.rotate(by: theta)
            
            // Translate up to the edge of the radius and 
            // move left by half the letter width.
            context.cgContext.translateBy(x: -letterSize / 2, y: -r)
            letter.draw(at: .zero)
        }
    }
}

image
// image.saveImage()
