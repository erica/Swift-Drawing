import UIKit

func pushDraw(in context: UIGraphicsImageRendererContext,
              applying actions: () -> Void)
{
    context.cgContext.saveGState()
    actions()
    context.cgContext.restoreGState()
}

let blendModes: [CGBlendMode] = [.normal, .multiply, .screen, .overlay, .darken, .lighten, .colorDodge, .colorBurn, .softLight, .hardLight, .difference, .exclusion, .hue, .saturation, .color, .luminosity, .clear, .copy, .sourceIn, .sourceOut, .sourceAtop, .destinationOver, .destinationIn, .destinationOut, .destinationAtop, .xor, .plusDarker, .plusLighter]

extension CGBlendMode {
    var name: String {
        let names = ["normal", "multiply", "screen", "overlay", "darken", "lighten", "colorDodge", "colorBurn", "softLight", "hardLight", "difference", "exclusion", "hue", "saturation", "color", "luminosity", "clear", "copy", "sourceIn", "sourceOut", "sourceAtop", "destinationOver", "destinationIn", "destinationOut", "destinationAtop", "xor", "plusDarker", "plusLighter"]
        return names[names.index(names.startIndex, offsetBy: Int(rawValue))]
    }
}

let shadow = NSShadow()
shadow.shadowColor = UIColor.black
shadow.shadowOffset = CGSize(width: 2, height: 2)
shadow.shadowBlurRadius = 3

let attributes = [
    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24.0),
    NSForegroundColorAttributeName: UIColor.white,
    NSShadowAttributeName: shadow]

func demonstrate(_ mode: CGBlendMode) -> UIImage {
    let size = CGSize(width: 300, height: 180)
    let format = UIGraphicsImageRendererFormat()
    format.opaque = false
    format.scale = 1.0 // direct scale
    format.prefersExtendedRange = true // wide colors
    let renderer = UIGraphicsImageRenderer(size: size, format: format)
    
    // Create an image with the renderer
    return renderer.image { context in
        
        // Subdivide bounds
        let bounds = context.format.bounds
        let width = bounds.size.width
        let rects1 = bounds.divided(atDistance: 0.6 * width, from: .maxXEdge)
        let rects2 = bounds.divided(atDistance: 0.6 * width, from: .minXEdge)
        
        let (green, purple) = (#colorLiteral(red: 0.490196079, green: 0.6352941394, blue: 0.2470588237, alpha: 1), #colorLiteral(red: 0.3882353008, green: 0.2431372553, blue: 0.6352941394, alpha: 1))
        
        // Draw green circle first
        green.set()
        UIBezierPath(ovalIn: rects2.0).fill()

        // Next draw purple circle using current blend mode
        pushDraw(in: context) {
            context.cgContext.setBlendMode(mode)
            purple.set()
            UIBezierPath(ovalIn: rects1.0).fill()
        }
        
        let legend = NSAttributedString(string: mode.name, attributes: attributes)
        legend.draw(at: CGPoint(x: 80, y: 80))
    }
}

for mode in blendModes {
    let image = demonstrate(mode)
    image
    // image.saveImage("kCGBlendMode" + mode.name.capitalized)
}
