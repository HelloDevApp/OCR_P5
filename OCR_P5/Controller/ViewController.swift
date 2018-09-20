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
    // MARK: - @IBOutlets
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
    // MARK: - Standard Methods
    //-------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    }
    //center layoutButton in portrait and landscape mode
    @IBAction func layoutButton2Tapped(_ sender: UIButton) {
        displaysLayout(layoutStyle: .rectangularBottomView)
    }
    //layoutButton is on the right in portrait mode ⚠️layoutButton is on the bottom in landscape mode⚠️
    @IBAction func layoutButtonTapped(_ sender: UIButton) {
    }
    
    
    
    //-----------------------------------------------------
    // MARK: - Settings
    //-----------------------------------------------------
    
    func displaysLayout(layoutStyle: Layout) {
        switch layoutStyle {
        case .rectangularBottomView:
            squareViewR2.isHidden = true
            print(squareViewR2.isHidden)
            
        case .rectangularTopView:
            break
        case .squareView:
            break
        }
    }
}

