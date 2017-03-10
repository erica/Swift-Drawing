import UIKit
import PlaygroundSupport

extension UIImage {
    public func saveImage(_ name: String = "New") {
        #if arch(x86_64) || arch(i386)
            guard let data = UIImagePNGRepresentation(self) else { return }
            let sharedFolderURL = playgroundSharedDataDirectory.appendingPathComponent("Drawing")
            let _ = try? FileManager.default.createDirectory(at: sharedFolderURL, withIntermediateDirectories: true, attributes: nil)
            let destinationURL = sharedFolderURL.appendingPathComponent(name + ".png")
            guard let _ = try? data.write(to: destinationURL) else {
                print("Failed to write data"); return
            }
            print("cp '\(destinationURL.path)' /Users/ericasadun/drawing/writing/images/A01/" + name + ".png")
        #endif
    }
}
