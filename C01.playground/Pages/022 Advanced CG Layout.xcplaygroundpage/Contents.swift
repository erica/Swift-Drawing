import UIKit

func pushDraw(in context: UIGraphicsImageRendererContext,
              applying actions: () -> Void)
{
    context.cgContext.saveGState()
    actions()
    context.cgContext.restoreGState()
}

// Basic layout
let π = CGFloat(Double.pi)
let size = CGSize(width: 600, height: 200)
let renderer = UIGraphicsImageRenderer(size: size)
let attributes = [
    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12.0),
    NSForegroundColorAttributeName: UIColor.black
]

// Convert characters to attributed strings and measure them
let characters = CharacterSet.uppercaseEnglishLetterSet.members
let letters = characters
    .map({ String($0) })
    .map({ NSAttributedString(string: $0, attributes: attributes) })
let letterSizes = letters.map({ $0.size().width })

// Draw along sin curve
let image = renderer.image { context in
    let bounds = context.format.bounds
    let centerY = bounds.midY
    let r = bounds.midY * 0.7
    let dπ: CGFloat = 0.05
    let xOffset: CGFloat = 20
    let nCycles: CGFloat = 3
    let dx: CGFloat = (size.width - 2 * xOffset) / (2 * nCycles / dπ)
    var (px, py) = (xOffset, centerY)
    let letterPairs = Array(zip(letters, letterSizes))
    
    for (offset, theta) in stride(from: dπ, through: 2 * nCycles * π, by: π * dπ).enumerated()
    {
        let letterPair = letterPairs[offset % 26]
        let halfWidth = letterPair.1 / 2
        let (x, y) = (xOffset + CGFloat(offset) * dx, centerY + r * sin(theta))
            defer { px = x; py = y }
        let (dx, dy) = (x - px, y - py)
        let phi = atan2(dy, dx)
        
        pushDraw(in: context) {
            context.cgContext.translateBy(x: x, y: y)
            context.cgContext.rotate(by: phi)
            context.cgContext.translateBy(x: -halfWidth, y: 0)
            letterPair.0.draw(at: .zero)
        }
    }
}

/*
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
*/

image
image.saveImage()
