//
//  ShadowView.swift
//  Cocktail DB
//
//  Created by Sasha on 09/09/2020.
//  Copyright © 2020 Sasha. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }
    
    func setupShadow() {
        let shadowHeight: CGFloat = 2
        let shadowRadius: CGFloat = 3
        let width = self.frame.width
        let height = self.frame.height

        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: shadowRadius / 2, y: height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadius / 2, y: height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: width, y: height +  shadowHeight))
        shadowPath.addLine(to: CGPoint(x: 0, y: height + shadowHeight))
        
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.2
    }
}
