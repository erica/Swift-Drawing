import UIKit
import CoreImage

//: # Core Image Filter Examples
import UIKit
import QuartzCore

// Common components
var filter : CIFilter
var transform : CGAffineTransform
var value : NSValue

enum Problem: Error { case filter }
//: **Creating Filters**: All these filters share some base functionality, in which the filter is established, the defaults set, and the input image added. The following function establishes a new `CIFilter` and performs these basic setup tasks, including converting a `UIImage` instance to a `CIImage` one.
func establishFilter(name : String, image : UIImage) throws -> CIFilter {
    guard let filter = CIFilter(name:name) else { throw Problem.filter }
    filter.setDefaults()
    filter.setValue(CIImage(cgImage:image.cgImage!), forKey: "inputImage")
    return filter
}

//: **Source**: This is the original image, which is used as the baseline input for all the filters that follow.
guard let image = UIImage(named:"landscape600") else { fatalError("Image not found") }
image

/*:
 
 ### Vibrancy
 
 The vibrancy filter selectively adjusts image saturation while retaining overall tones.
 - experiment: Try adjusting the filter key down from 1.0 to, for example, 0.25 and 0.5, to see the effect in action. The closer the value goes to 0, the more the output image resembles the input image.
 */
filter = try! establishFilter(name: "CIVibrance", image: image)
filter.setValue(1.0, forKey: "inputAmount")
image
filter.outputImage

/*:
 
 ### Color Controls
 
 Desaturate using color controls, creating a black and white rendition.
 
 - note: As the saturation value decreases from 1.0, the color returns to the results.
 */
filter = try! establishFilter(name: "CIColorControls", image: image)
filter.setValue(1.0, forKey: "inputSaturation")
filter.outputImage

/*:
 
 ### Affine Transforms
 
 Apply affine transform, in this case a simple rotation.
 
 - experiment: Try adjusting the rotation levels somewhere between -6.28 and 6.28.
 */
filter = try! establishFilter(name: "CIAffineTransform", image: image)
transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4 * 0.8))
value = NSValue(cgAffineTransform:transform)
filter.setValue(value, forKey: "inputTransform")
filter.outputImage

/*:
 
 ### Posterizing
 
 Posterizing means reducing the number of colors used to render the image. Adjust the number of inputLevels higher or lower to explore. The higher the number, the more the output image resembles the input one.
 */
filter = try! establishFilter(name: "CIColorPosterize", image: image)
filter.setValue(8, forKey: "inputLevels")
filter.outputImage

