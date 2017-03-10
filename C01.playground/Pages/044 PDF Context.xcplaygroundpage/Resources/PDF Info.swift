
/*
The keys in this dictionary are the same keys you pass to the CGPDFContextCreate function and are described in the Auxiliary Dictionary Keys section of CGPDFContext. The dictionary is retained by the new context, so on return you may safely release it.

kCGPDFContextAuthor
The corresponding value is a string that represents the name of the person who created the document. This key is optional.
kCGPDFContextCreator
The corresponding value is a string that represents the name of the application used to produce the document. This key is optional.
kCGPDFContextTitle
The corresponding value is a string that represents the title of the document. This key is optional.
kCGPDFContextOwnerPassword
kCGPDFContextUserPassword
kCGPDFContextAllowsPrinting
Whether the document allows printing when unlocked with the user password. The value of this key must be a CFBoolean value. The default value of this key is YES.
kCGPDFContextAllowsCopying
Whether the document allows copying when unlocked with the user password. The value of this key must be a CFBoolean object. The default value of this key is YES.
kCGPDFContextOutputIntent
kCGPDFContextOutputIntents
kCGPDFContextSubject
kCGPDFContextKeywords
kCGPDFContextEncryptionKeyLength

BOX KEYS:


kCGPDFContextMediaBox
The media box for the document or for a given page. This key is optional. If present, the value of this key must be a CFDataRef object that contains a CGRect (stored by value, not by reference).
kCGPDFContextCropBox
The crop box for the document or for a given page. This key is optional. If present, the value of this key must be a CFDataRef object that contains a CGRect (stored by value, not by reference).
kCGPDFContextBleedBox
The bleed box for the document or for a given page. This key is optional. If present, the value of this key must be a CFDataRef object that contains a CGRect (stored by value, not by reference).
kCGPDFContextTrimBox
The trim box for the document or for a given page. This key is optional. If present, the value of this key must be a CFDataRef object that contains a CGRect (stored by value, not by reference).
kCGPDFContextArtBox
The art box for the document or for a given page. This key is optional. If present, the value of this key must be a CFDataRef object that contains a CGRect (stored by value, not by reference).

OUTPUT INTENT KEYS:


kCGPDFXOutputIntentSubtype
The output intent subtype. This key is required. The value of this key must be a CFStringRef object equal to "GTS_PDFX"; otherwise, the dictionary is ignored.
kCGPDFXOutputConditionIdentifier
kCGPDFXOutputCondition
A text string identifying the intended output device or production condition in a human- readable form. This key is optional. If present, the value of this key must be a CFStringRef object.
kCGPDFXRegistryName
kCGPDFXInfo
kCGPDFXDestinationOutputProfile

open func beginPage()

open func beginPage(withBounds bounds: CGRect, pageInfo: [String : Any])


open func setURL(_ url: URL, for rect: CGRect)

open func addDestination(withName name: String, at point: CGPoint)

open func setDestinationWithName(_ name: String, for rect: CGRect)

open func writePDF(to url: URL, withActions actions: (UIGraphicsPDFRendererContext) -> Swift.Void) throws

open func pdfData(actions: (UIGraphicsPDFRendererContext) -> Swift.Void) -> Data

*/

