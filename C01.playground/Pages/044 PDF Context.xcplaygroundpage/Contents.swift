import UIKit

// Fetch 10 long paragraphs of lorem ipsum text
func text() -> String {
    guard let ipsumURL = URL(string: "http://loripsum.net/api/10/long/plaintext")
        else { return "Bad URL" }
    guard let string = try? String(contentsOf: ipsumURL)
        else { return "No data" }
    return string
}

// Establish Attributes
func attributeDictionary() -> [String: Any] {
    let style = NSMutableParagraphStyle()
    style.alignment = .left
    style.lineBreakMode = .byWordWrapping
    return [
        NSForegroundColorAttributeName: UIColor.black,
        NSFontAttributeName: UIFont.systemFont(ofSize: 18),
        NSParagraphStyleAttributeName: style
    ]
}
let attributes = attributeDictionary()

// Establish renderer
let size = CGSize(width: 850, height: 1100) // 8.5 x 11 @ 100 dpi
let rect = CGRect(origin: .zero, size: size)
let renderer = UIGraphicsPDFRenderer(bounds: rect)

// Build PDF data
let pdfData = renderer.pdfData { context in
    let drawingRect = rect.insetBy(dx: 100, dy: 100) // 1-inch insets
    
    // Draw three pages of random nonsense
    (1 ... 3).forEach {
        _ in
        context.beginPage()
        let attributedString = NSAttributedString(string: text(), attributes: attributes)
        attributedString.draw(in: drawingRect)
    }
}

// pdfData.savePDFData()


