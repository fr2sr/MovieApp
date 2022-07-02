//
//  UIViewControllerExtension.swift
//  MovieApp
//
//  Created by Sohanur Rahman on 2/7/22.
//

import UIKit

extension UIViewController {
    
    func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
