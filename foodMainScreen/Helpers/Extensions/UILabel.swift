//
//  UILabel.swift
//  test1
//
//  Created by Артем Макар on 12.04.23.
//
import UIKit
extension UILabel {
    
    var lines: [String]? {

        guard let text = text, let font = font else { return nil }

        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: attStr.length))

        let frameSetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: .greatestFiniteMagnitude))
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attStr.length), path.cgPath, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else { return nil }

        var linesArray: [String] = []

        for line in lines {
            let lineRef = line as! CTLine
            let lineRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
    }
}
