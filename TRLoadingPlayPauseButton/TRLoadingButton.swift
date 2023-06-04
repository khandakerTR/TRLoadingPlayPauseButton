//
//  TRLoadingButton.swift
//  TRLoadingPlayPauseButton
//
//  Created by BCL-Device-11 on 4/6/23.
//

import UIKit

class TRLoadingButton: UIButton {

    var spinner = UIActivityIndicatorView(style: .large)
    var isLoading = false {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        spinner.hidesWhenStopped = true
        spinner.color = .white
        spinner.style = .medium
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func updateView() {
        if isLoading {
            spinner.startAnimating()
            imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
            isEnabled = false
        } else {
            imageView?.layer.transform = CATransform3DIdentity
            spinner.stopAnimating()
            isEnabled = true
        }
    }
}


