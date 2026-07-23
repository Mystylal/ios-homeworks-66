//
//  CustomButton.swift
//  Navigation
//
//  Created by Mysty Mystylal on 22.07.2026.
//

import UIKit

class CustomButton: UIButton{
    private var action: (() -> Void)?
    
    init(title: String, titleColor: UIColor, backgroundColor: UIColor? = nil, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.action = action
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(){
        action?()
    }
}

