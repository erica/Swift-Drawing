import UIKit

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
    UIColor.white.set(); UIRectFill(bounds)
    let r: CGFloat = 70
    
    for (idx, (letter, letterSize)) in
        zip(letters, letterSizes).enumerated()
    {
        let theta = π - CGFloat(idx) * (2 * π) / 26.0
        let x = centerX + r * sin(theta) - letterSize / 2
        let y = centerY + r * cos(theta) - letterSize / 2
        letter.draw(at: CGPoint(x: x, y: y))
    }
}

image
// image.saveImage()
