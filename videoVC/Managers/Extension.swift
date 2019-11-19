//
//  Extension.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import Foundation
import UIKit


class SupportClass: NSObject {
    enum Dimensions {
        static let hDdevice = UIScreen.main.bounds.size.height
        static let wDdevice = UIScreen.main.bounds.size.width
    }
}



extension UIView {
    @objc func loadViewFromNib(_ name: String) -> UIView { //добавление вью созданной в ксиб файле
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        } else {
            return UIView()
        }
    }


    func roundedView(rect: UIRectCorner) { //закругление 2х углов вьюшки
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: rect, //[.topLeft, .bottomLeft]
            cornerRadii: CGSize(width: 8, height: 8))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }

    func addRadius(number: CGFloat) {
        self.layer.cornerRadius = number
        self.layer.masksToBounds = true
    }

    func cirkleView() {
        let radius = self.frame.height / 2
        self.addRadius(number: radius)
    }

    func addGradient() { //градиент фона изображения
        let gradient = CAGradientLayer()

        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]

        self.layer.insertSublayer(gradient, at: 0)
    }

    func recurrenceAllSubviews() -> [UIView] {//получение всех UIView
        var all = [UIView]()
        func getSubview(view: UIView) {
            all.append(view)
            guard !view.subviews.isEmpty else {
                return
            }
            view.subviews.forEach { getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }

    func opasityAllViews(_ alpha: CGFloat) { //функция что выше но сразу делаем все прозрачным
        if alpha <= 1 && 0 <= alpha {
            var allViews = self.subviews
            allViews.append(self)
            for view in allViews {
                view.alpha = alpha
            }
        }
    }
}

class TouchthruView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in self.subviews {
            if view.isHidden {
                continue
            }
            if view.bounds.contains(view.convert(point, from: self)) {
                return true
            }
        }
        return false
    }
}
