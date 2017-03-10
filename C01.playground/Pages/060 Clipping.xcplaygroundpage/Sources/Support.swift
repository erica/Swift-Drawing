import UIKit

// As in previous playground page, these functions
// allows drawing in a Quartz-flipped context

public func pushDraw(in context: UIGraphicsImageRendererContext,
              applying actions: () -> Void)
{
    context.cgContext.saveGState()
    actions()
    context.cgContext.restoreGState()
}


public func drawFlipped(in context: UIGraphicsImageRendererContext,
                 applying actions: () -> Void)
{
    pushDraw(in: context) {
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(
            x: 0, y: -context.format.bounds.size.height)
        context.cgContext.concatenate(transform)
        actions()
    }
}

