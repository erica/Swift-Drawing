/*
 
 Erica Sadun, http://ericasadun.com
 Random Numbers
 
 */

import UIKit

// --------------------------------------------------
// MARK: Random numbers
// --------------------------------------------------

public struct Random {
    public static var initialized = false
    
    /// Returns random value from 0 ..< max
    public static func roll(max: Int) -> Int {
        precondition(max > 0, "random value requires positive integer")
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    /// Returns random value within range
    public static func roll(in range: ClosedRange<Int> = 1 ... 10) -> Int {
        let lower = range.lowerBound
        let extent = range.upperBound - range.lowerBound
        return lower + roll(max: extent)
    }
    
    /// Returns a uniform random value in 0.0 ..< 1.0
    public static func uniform() -> CGFloat {
        return (CGFloat(arc4random()) / CGFloat(UInt32.max))
    }
    
    /// Returns true or false, whether a uniform value falls below cutoff
    public static func uniformTest(cutoff: CGFloat = 0.5) -> Bool {
        precondition(cutoff > 0.0, "random value requires positive cutoff")
        return  Random.uniform() <= cutoff
    }
}
