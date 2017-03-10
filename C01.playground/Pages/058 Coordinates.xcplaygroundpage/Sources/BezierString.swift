import UIKit

import UIKit

/// Character and String initialization
extension UIBezierPath {
    /// Returns a path created from the character and the optional UIFont
    public convenience init? (
        character: Character,
        font: UIFont = UIFont.boldSystemFont(ofSize: 32.0)) {
        self.init()
        var glyph = CGGlyph()
        guard let unichar = String(character).utf16.first else { return nil }
        var chars = [unichar]
        if CTFontGetGlyphsForCharacters(font, &chars, &glyph, 1) {
            guard let ctLetterPath = CTFontCreatePathForGlyph(font, glyph, nil) else { return nil }
            self.append(UIBezierPath(cgPath: ctLetterPath))
        } else { return nil }
    }
    
    /// Returns a path created from the character and the font name and size
    public convenience init? (
        character: Character,
        face: String = UIFont.boldSystemFont(ofSize: 32.0).fontName,
        size: CGFloat) {
        guard let font = UIFont(name: face, size: size) else { return nil }
        self.init(character: character, font: font)
    }
    
    /// Returns a path created from the supplied string and the optional font
    public convenience init? (string: String, font: UIFont = UIFont.boldSystemFont(ofSize: 32.0)) {
        self.init()
        for character in string.characters {
            let size = NSString(string: String(character)).size(attributes: [NSFontAttributeName: font])
            if let charPath = UIBezierPath(character: character, font: font) {
                append(charPath) }
            apply(CGAffineTransform(translationX: -size.width, y: 0))
        }
        apply(CGAffineTransform(translationX: -bounds.origin.x, y: 0))
    }
    
    /// Returns a path created from the supplied string and the font name and size
    public convenience init? (
        string: String,
        face: String = UIFont.boldSystemFont(ofSize: 32.0).fontName,
        size: CGFloat) {
        guard let font = UIFont(name: face, size: size) else { return nil }
        self.init(string: string, font: font)
    }
}


