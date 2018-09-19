//
//  LayoutCustomView.swift
//  OCR_P5
//
//  Created by Mac Book Pro on 18/09/2018.
//  Copyright © 2018 dylan. All rights reserved.
//

import UIKit

enum LayoutStyle {
    case rectangularBottomView
    case rectangularTopView
    case fourSquareView
    
}

class LayoutCustomView: UIView {

    //square view located at the top left
    @IBOutlet weak var squareViewL1: UIView!
    //image view located at the top left
    @IBOutlet weak var imageViewL1: UIImageView!
    //square view located at the bottom left
    @IBOutlet weak var squareViewL2: UIView!
    //image view located at the bottom left
    @IBOutlet weak var imageViewL2: UIImageView!
    //square view located at the top right
    @IBOutlet weak var squareViewR1: UIView!
    //image view located at the top right
    @IBOutlet weak var imageViewR1: UIImageView!
    //square view located at the bottom right
    @IBOutlet weak var squareViewR2: UIView!
    //image view located at the bottom right
    @IBOutlet weak var imageViewR2: UIImageView!
    
    
    
    
    //function that displays the selected layout
    func displaysLayout(layoutStyle: LayoutStyle) {
        
        switch layoutStyle {
        case .rectangularBottomView:
            break
        case .rectangularTopView:
            break
        case .fourSquareView:
            break
        }
    }
    
}
