/*
 
 Erica Sadun, http://ericasadun.com
 Random Letters
 
 */

import Foundation

// controlCharacterSet, whitespaceCharacterSet, whitespaceAndNewlineCharacterSet, decimalDigitCharacterSet, letterCharacterSet, lowercaseLetterCharacterSet, uppercaseLetterCharacterSet, nonBaseCharacterSet, alphanumericCharacterSet, decomposableCharacterSet, illegalCharacterSet, punctuationCharacterSet, capitalizedLetterCharacterSet, symbolCharacterSet, newlineCharacterSet


// --------------------------------------------------
// MARK: Letters
// --------------------------------------------------

extension CharacterSet {
    /// English Alphabet
    public static var uppercaseEnglishLetterSet: CharacterSet {
        return self.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    }
    
    /// English Alphabet
    public static var lowercaseEnglishLetterSet: CharacterSet {
        return self.init(charactersIn: "abcdefghijklmnopqrstuvwxyz")
    }
}

// --------------------------------------------------
// MARK: Members
// --------------------------------------------------

extension CharacterSet {
    
    /// Return set members
    public var members: [String] {
        let scalars = Array(unichar(0)..<unichar(1024))
            .map({ UnicodeScalar($0)! })
            .filter({ contains($0) })
        return scalars.map({ String($0) })
    }
    
    
    /// Member sequence, no guarantee of order but
    /// will be the same every time
    public func generate() -> AnySequence<String> {
        return AnySequence(members)
    }
    
    /// Random members
    public func randomMemberSequence(count: Int = 0) -> AnySequence<String> {
        var chars = members
        precondition(count < chars.count, "Cannot shuffle more than member count")
        var count = count > 0 ? count : members.count
        return AnySequence {
            return AnyIterator {
                defer { count -= 1 }
                guard count > 0 else { return nil }
                let index = Int(arc4random_uniform(numericCast(chars.count)))
                return chars.remove(at: index)
            }
        }
    }
    
    /// Permutation generator, no duplicates
    public var permutedMemberSequence: AnySequence<String> {
        return randomMemberSequence()
    }
    
    /// Random generator, will include duplicates
    /// and will not terminate
    public func generateRandom() -> AnySequence<String> {
        let myMembers = members
        let myCount = myMembers.count
        let randomNumber = { Int(arc4random_uniform(UInt32(myCount))) }
        return AnySequence{ AnyIterator{ return myMembers[ randomNumber() ] }}
    }
}
