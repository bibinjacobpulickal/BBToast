//
//  BBToast.swift
//  BBToast
//
//  Created by Bibin Jacob Pulickal on 16/05/20.
//

import UIKit

public final class BBToast: UILabel {

    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = newValue ?? UIColor(white: 0, alpha: 0.5)
        }
        get {
            super.backgroundColor
        }
    }

    public override var textColor: UIColor? {
        set {
            super.textColor = newValue ?? .white
        }
        get {
            super.textColor
        }
    }

    public override var font: UIFont! {
        set {
            super.font = newValue ?? .systemFont(ofSize: 15)
        }
        get {
            super.font
        }
    }

    public var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    public init(_ text: String = "") {
        super.init(frame: .zero)
        self.text = text

        numberOfLines      = 0
        alpha              = 0
        layer.cornerRadius = 8
        backgroundColor    = UIColor(white: 0, alpha: 0.5)
        textColor          = .white
        textAlignment      = .center
        font               = .systemFont(ofSize: 15)
        clipsToBounds      = true

        translatesAutoresizingMaskIntoConstraints = false
        textInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect      = bounds.inset(by: textInsets)
        let textRect       = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override public func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    func show(onView view: UIView, forDuration duration: Double) {

        view.addSubview(self)

        if #available(iOS 11.0, tvOS 11.0, *) {
            NSLayoutConstraint.activate([
                self.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                self.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                self.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
            ])
        } else {
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: view, attribute: .leading, multiplier: 1, constant: 16),
                NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: view, attribute: .trailing, multiplier: 1, constant: -16),
                NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -32)
            ])
        }

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
}
