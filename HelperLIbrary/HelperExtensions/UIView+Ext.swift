//
//  UIView+Ext.swift
//  HelperLIbrary
//
//  Created by Vatsal Shukla on 10/07/22.
//

import UIKit

extension UIView {
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    func createGradientLayer(_ colors: [CGColor] , _ startPoint: CGPoint = CGPoint(x: 0, y: 1) , _ endPoint: CGPoint = CGPoint(x: 0, y: 0)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.addSublayer(gradientLayer)
    }
    
    func takeScreenshot() -> UIImage {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if (image != nil) {
            return image!
        }
        return UIImage()
    }
    
    func snapshot(of rect: CGRect? = nil, afterScreenUpdates: Bool = true) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
        }
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    //for easy application of anchors
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }

    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }

    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }

    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }

    
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}


//MARK: - UICollectionReusableView
extension UICollectionReusableView {
    
    ///Use class name as ReuseIdentifire
    static var id:String {
        return String(describing: self)
    }
    
    ///Use class name to get UINib
    static var xib:UINib {
        return UINib(nibName: id, bundle: .main)
    }
    
    class func reuseHeader(on cln:UICollectionView,at ip:IndexPath) -> Self {
        return initialise(on: cln, at: ip, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader)
    }
    
    class func reuseFooter(on cln:UICollectionView,at ip:IndexPath) -> Self {
        return initialise(on: cln, at: ip, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter)
    }
    
    class private func initialise<T:UICollectionReusableView>(on cln:UICollectionView,at ip:IndexPath, viewForSupplementaryElementOfKind kind:String) -> T {
        return cln.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: ip) as! T
    }
    
}

//MARK: - UICollectionViewCell
extension UICollectionViewCell {
    
    class func reuseCell(on cln:UICollectionView,at ip:IndexPath) -> Self {
        return initialise(on: cln, at: ip)
    }
    
    class private func initialise<T:UICollectionViewCell>(on cln:UICollectionView,at ip:IndexPath) -> T {
        return cln.dequeueReusableCell(withReuseIdentifier: id, for: ip) as! T
    }
}

//MARK: - UITableViewHeaderFooterView
extension UITableViewHeaderFooterView {
    ///Use class name as ReuseIdentifire
    static var id:String {
        return String(describing: self)
    }
    
    ///Use class name to get UINib
    static var xib:UINib {
        return UINib(nibName: id, bundle: .main)
    }
    
    
    class func reuseView(on tbl:UITableView) -> Self {
        return initialise(on: tbl)
    }
    
    class private func initialise<T:UITableViewHeaderFooterView>(on tbl:UITableView) -> T {
        return tbl.dequeueReusableHeaderFooterView(withIdentifier: id) as! T
    }
}

//MARK: - UICollectionView
extension UICollectionView {
    
    ///Only returns array of fully visible IndexPaths
    var fullyVisibleIndexPaths:Array<IndexPath> {
        var ips = Array<IndexPath>()
        var vCells = self.visibleCells
        vCells = vCells.filter({ cell -> Bool in
            let cellRect = self.convert(cell.frame, to: self.superview)
            return self.frame.contains(cellRect)
        })
        vCells.forEach({
            if let pth = self.indexPath(for: $0) {
                ips.append(pth)
            }
        })
        return ips
    }
    
    var fullyVisibleIndexPath:IndexPath? {
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        return visibleIndexPath
    }
}

//MARK: - UITableViewCell
extension UITableViewCell {
    
    ///Use class name as ReuseIdentifire
    static var id:String {
        return String(describing: self)
    }
    
    ///Use class name to get UINib
    static var xib:UINib {
        return UINib(nibName: id, bundle: .main)
    }
    
    class func reuseCell(on tbl:UITableView,at ip:IndexPath) -> Self {
        return initialise(on: tbl, at: ip)
    }
    
    class private func initialise<T:UITableViewCell>(on tbl:UITableView,at ip:IndexPath) -> T {
        return tbl.dequeueReusableCell(withIdentifier: id, for: ip) as! T
    }
}
