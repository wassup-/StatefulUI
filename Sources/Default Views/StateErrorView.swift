//
//  StateErrorView.swift
//  StatefulUI
//
//  Created by David Jennes on 02/04/2019.
//  Copyright © 2019 Appwise. All rights reserved.
//

import Reusable
import UIKit

public final class StateErrorView: UIView {
	// swiftlint:disable private_outlet
	@IBOutlet public var imageView: UIImageView?
	@IBOutlet public var titleLabel: UILabel?
	@IBOutlet public var subtitleLabel: UILabel?
	@IBOutlet public var button: UIButton?
	// swiftlint:enable private_outlet

	public weak var delegate: PlaceholderViewDelegate?

	@objc public dynamic var titleColor: UIColor? = .black {
		didSet { titleLabel?.textColor = titleColor }
	}

	@objc public dynamic var subtitleColor: UIColor? = .black {
		didSet { subtitleLabel?.textColor = titleColor }
	}

	@objc public dynamic var buttonBackgroundColor: UIColor? = .clear {
		didSet { button?.backgroundColor = buttonBackgroundColor }
	}

	@IBAction private func tappedButton() {
		delegate?.tappedPlaceholderButton(in: self)
	}
}

extension StateErrorView: NibReusable {
	public static var nib: UINib {
		return UINib(nibName: String(describing: self), bundle: .resources)
	}
}

extension StateErrorView: StatefulPlaceholderView {
	public func placeholderViewInsets() -> UIEdgeInsets {
		return UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
	}
}

// MARK: Easy initializer

extension StateErrorView {
	public static func load(image: UIImage? = nil, title: String = "", subtitle: String = StatefulUIStrings.Message.error, buttonTitle: String = StatefulUIStrings.Button.refresh, delegate: PlaceholderViewDelegate? = nil) -> StateErrorView {
		let view = loadFromNib()
		view.configure(image: image, title: title, subtitle: subtitle, buttonTitle: buttonTitle, delegate: delegate)
		return view
	}

	public func configure(image: UIImage? = nil, title: String = "", subtitle: String = StatefulUIStrings.Message.error, buttonTitle: String = StatefulUIStrings.Button.refresh, delegate: PlaceholderViewDelegate? = nil) {
		imageView?.image = image
		imageView?.isHidden = image == nil

		titleLabel?.text = title
		titleLabel?.isHidden = title.isEmpty

		subtitleLabel?.text = subtitle
		subtitleLabel?.isHidden = subtitle.isEmpty

		button?.setTitle(buttonTitle, for: .normal)
		button?.isHidden = buttonTitle.isEmpty

		self.delegate = delegate
	}
}
