//
//  ViewController.swift
//  OCR_P5
//
//  Created by Mac Book Pro on 09/09/2018.
//  Copyright © 2018 dylan. All rights reserved.
//

import UIKit

//--------------------------------------------------
// MARK: - Enumeration
//-------------------------------------------------
enum Layout {
    case rectangularBottomView
    case rectangularTopView
    case squareView
}


class ViewController: UIViewController {

    //--------------------------------------------------
    // MARK: - @IBOutlets: StackViewTop and Bottom
    //--------------------------------------------------
    
    //Top StackView
    @IBOutlet weak var stackViewTop: UIStackView!
    //Top Left squareView
    // ⚠️1 = Top    ⚠️2 = Bottom    ⚠️L = Left    ⚠️R = Right
    @IBOutlet weak var squareViewL1: UIView!
    //Top Left imageView
    @IBOutlet weak var imageViewL1: UIImageView!
    //Top Right squareView
    @IBOutlet weak var squareViewR1: UIView!
    //Top Right squareView
    @IBOutlet weak var imageViewR1: UIImageView!
    //--------------------------------------------------
    
    //Bottom StackView
    @IBOutlet weak var stackViewBottom: UIStackView!
    //Bottom Left squareView
    // ⚠️1 = Top    ⚠️2 = Bottom    ⚠️L = Left    ⚠️R = Right
    @IBOutlet weak var squareViewL2: UIView!
    //Bottom Left imageView
    @IBOutlet weak var imageVieWL2: UIView!
    //Bottom Right squareVIew
    @IBOutlet weak var squareViewR2: UIView!
    //Bottom Right imageView
    @IBOutlet weak var imageViewR2: UIView!
    
    //--------------------------------------------------
    // MARK: - @IBOutlets: LayoutButton
    //--------------------------------------------------
    //PORTRAIT MODE: ⚠️1 = Left   ⚠️2 = Center   ⚠️2 = Right
    //LANDSCAPE MODE: ⚠️1 = Top   ⚠️2 = Center   ⚠️2 = Bottom
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    
    
    //--------------------------------------------------
    // MARK: - Properties
    //-------------------------------------------------
    
    
    
    //--------------------------------------------------
    // MARK: - Constraints
    //-------------------------------------------------
    
    //constraint use to have a square view
    @IBOutlet weak var squareViewL2Ratio: NSLayoutConstraint!
    @IBOutlet weak var squareViewL1Ratio: NSLayoutConstraint!
    
    //--------------------------------------------------
    // MARK: - Standard Methods
    //-------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        squareViewL1Ratio.isActive = false
        squareViewL2Ratio.isActive = false
        displaysLayout(layoutStyle: .rectangularBottomView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //--------------------------------------------------
    // MARK: - Layout Buttons @IBAction
    //-------------------------------------------------
    
    //layoutButton is on the left in portrait mode ⚠️layoutButton is on the top in landscape mode⚠️
    @IBAction func layoutButton1Tapped(_ sender: UIButton) {
        disabledButton(disabled: layoutButton1, enabled1: layoutButton2, enabled2: layoutButton3)
        displaysLayout(layoutStyle: .rectangularTopView)
    }
    //center layoutButton in portrait and landscape mode
    @IBAction func layoutButton2Tapped(_ sender: UIButton) {
        disabledButton(disabled: layoutButton2, enabled1: layoutButton1, enabled2: layoutButton3)
        displaysLayout(layoutStyle: .rectangularBottomView)
    }
    //layoutButton is on the right in portrait mode ⚠️layoutButton is on the bottom in landscape mode⚠️
    @IBAction func layoutButton3Tapped(_ sender: UIButton) {
        disabledButton(disabled: layoutButton3, enabled1: layoutButton1, enabled2: layoutButton2)
        displaysLayout(layoutStyle: .squareView)
    }
    
    
    
    //-----------------------------------------------------
    // MARK: - Settings
    //-----------------------------------------------------
    
    func displaysLayout(layoutStyle: Layout) {
        
        switch layoutStyle {
            
            
        case .rectangularBottomView:
            chooseLayout(layoutStyle: .rectangularBottomView)
        case .rectangularTopView:
            chooseLayout(layoutStyle: .rectangularTopView)
        case .squareView:
            chooseLayout(layoutStyle: .squareView)
        }
    }
    func disabledButton(disabled: UIButton, enabled1: UIButton, enabled2: UIButton) {
        
        disabled.isEnabled = false
        enabled1.isEnabled = true
        enabled2.isEnabled = true
        
    }
    func chooseLayout(layoutStyle: Layout) {
        switch layoutStyle {
        case .rectangularBottomView:
            squareViewR2.isHidden = true
            imageViewR2.isHidden = true
            squareViewR1.isHidden = false
            imageViewR1.isHidden = false
        case .rectangularTopView:
            squareViewR1.isHidden = true
            imageViewR1.isHidden = true
            squareViewR2.isHidden = false
            imageViewR2.isHidden = false
        case .squareView:
            squareViewR1.isHidden = false
            imageViewR1.isHidden = false
            squareViewR2.isHidden = false
            imageViewR2.isHidden = false
        }
    }
}

