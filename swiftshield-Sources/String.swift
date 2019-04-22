//
//  Regex.swift
//  swiftprotector
//
//  Created by Bruno Rocha on 1/18/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import Foundation

typealias RegexClosure = ((NSTextCheckingResult) -> String?)

func firstMatch(for regex: String, in text: String) -> String? {
    return matches(for: regex, in: text).first
}

func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range)}
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

extension String {
    func match(regex: String) -> [NSTextCheckingResult] {
        let regex = try! NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        let nsString = self as NSString
        return regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
    }

    static func random(length: Int, excluding: Set<String>) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers : NSString = "0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for i in 0 ..< length {
            let rand = arc4random_uniform(len)
            let characters: NSString = i == 0 ? letters : letters.appending(numbers as String) as NSString
            var nextChar = characters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return excluding.contains(randomString) ? random(length: length, excluding: excluding) : randomString
    }
}

extension String {
    static var storyboardClassNameRegex: String {
        return "((?<=customClass=\").*?(?=\" customModule)|(?<=action selector=\").*?(?=:\"))"
    }
}

extension String {
    static var storyboardIdRegex: String {
        return "((?<=storyboardIdentifier=\").*?(?=\" customModule)|(?<=action selector=\").*?(?=:\"))"
    }
}

extension String {
    var trueName: String {
        return components(separatedBy: "(").first ?? self
    }
}

extension String {
    private var spacedFolderPlaceholder: String {
        return "\u{0}"
    }

    var replacingEscapedSpaces: String {
        return replacingOccurrences(of: "\\ ", with: spacedFolderPlaceholder)
    }

    var removingPlaceholder: String {
        return replacingOccurrences(of: spacedFolderPlaceholder, with: " ")
    }
}
