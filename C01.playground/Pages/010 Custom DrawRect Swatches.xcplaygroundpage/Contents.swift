import UIKit

public class SwatchView: UIView {
    // Color attributes
    public let colorHex: String = "#FFAAFF"
    public let color = #colorLiteral(red: 1, green: 0.625, blue: 1, alpha: 1)
    public let colorName: String = "Light Lavender"

    // Basic setup
    public override required init(frame: CGRect = .zero) {
        super.init(frame: SwatchView.coreRect)
        backgroundColor = .clear
        SwatchView.borderPath.lineWidth = 6
    }
    
    // Required but unused
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Lazy attributes, including paragraph style
    private static func establishAttributes() -> [String: Any] {
        let style = NSMutableParagraphStyle()
            style.alignment = .left
            style.lineBreakMode = .byWordWrapping
        return [
            NSForegroundColorAttributeName: UIColor.black,
            NSFontAttributeName: SwatchView.font,
            NSParagraphStyleAttributeName: style
        ]
    }
    private static var attributes: [String: Any] = establishAttributes()
    private var attributes: [String: Any] = SwatchView.attributes
    
    public override func draw(_ rect: CGRect) {
        // Clip to drawing area
        SwatchView.borderPath.addClip()
        
        // Fill background
        UIColor.white.setFill(); SwatchView.borderPath.fill()

        // Draw hex
        let attributedHex = NSAttributedString(string: colorHex, attributes: attributes)
        attributedHex.draw(in: SwatchView.hexRect)
        
        // Draw swatch
        color.set(); UIRectFill(SwatchView.swatchRect)
        
        // Draw name
        let attributedName = NSAttributedString(string: colorName, attributes: attributes)
        attributedName.draw(in: SwatchView.nameRect)
        
        // Stroke and draw inner glow
        SwatchView.innerGlow.draw(in: SwatchView.drawingRect)
        UIColor.black.setStroke(); SwatchView.borderPath.stroke()
    }

    // A lot of fussy hand-adjusted drawing details
    // centralized to one place for easy tweaking
    private static let _width = 160
    private static let _swatchStart = 60
    private static let _swatchHeight = 120
    private static let _nameStart = 182
    private static let _height = 600
    
    // Destination rectangles
    private static let coreRect: CGRect = CGRect(x: 0, y: 0, width: _width, height: _height)
    private static let drawingRect: CGRect = coreRect.insetBy(dx: 4, dy: 4)
    private static let hexRect = drawingRect.insetBy(dx: 16, dy: 16)
    private static let swatchRect = CGRect(x: 0, y: _swatchStart, width: _width, height: _swatchHeight).insetBy(dx: 4, dy: 0)
    private static let nameRect = CGRect(x: 0, y: _nameStart, width: _width, height: _width).insetBy(dx: 16, dy: 0)

    // Shared assets
    private static let borderPath = UIBezierPath(roundedRect: drawingRect, cornerRadius: 24)
    private static let font = UIFont(name: "HelveticaNeue-Bold", size: 24)!
    private static let innerGlow = UIImage(named:"InnerGlow")!
}

let view = SwatchView()
