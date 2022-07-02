//
//  UIStringExtension.swift
//  MovieApp
//
//  Created by Sohanur Rahman on 2/7/22.
//

import Foundation
import UIKit

extension String{
    func getEstimatedTextHeight(_ size: CGSize, _ fontSize: CGFloat , _ isBold: Bool) -> CGFloat {
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: self).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)], context: nil)
        return estimatedFrame.width
    }
}
