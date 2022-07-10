//
//  UIViewController+Ext.swift
//  HelperLIbrary
//
//  Created by Vatsal Shukla on 10/07/22.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}

extension UIViewController {
    
    func addCustomBackButton(forgroundColor fc:UIColor = UIColor.darkGray,
                             backgroundColor bc:UIColor? = nil,
                             buttonSize size:CGSize = CGSize(width: 35, height: 35),
                             andSelector selector:Selector) -> UIBarButtonItem {
        
        let internalSize = CGSize(width: size.width - 10, height: size.height - 10)
        let shrBTN = UIButton(frame: CGRect(origin: CGPoint.zero, size: internalSize))
        shrBTN.setImage(UIImage(named: "ic_back")!.withTintColor(.white, renderingMode: .alwaysTemplate), for: .normal)
        shrBTN.addTarget(self, action: selector, for: .touchUpInside)
        shrBTN.tintColor = fc
        let shrView = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        shrView.backgroundColor = bc
        shrView.layer.cornerRadius = 10
        shrView.addSubview(shrBTN)
        shrBTN.center = shrView.center
        return UIBarButtonItem(customView: shrView)
    }
}
