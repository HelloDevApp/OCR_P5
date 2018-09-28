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
    // ⚠️1 = Top    ⚠️2 = Bottom    ⚠️L = Left    ⚠️R = Right
    //Top Left squareView
    @IBOutlet weak var squareViewL1: UIView!
    //Top Left imageView
    @IBOutlet weak var imageViewL1: UIImageView!
    //Top Left Button
    @IBOutlet weak var pickImageButtonL1: UIButton!
    //Top Right squareView
    @IBOutlet weak var squareViewR1: UIView!
    //Top Right squareView
    @IBOutlet weak var imageViewR1: UIImageView!
    //Top Right button
    @IBOutlet weak var pickImageButtonR1: UIButton!
    //--------------------------------------------------
    
    //Bottom StackView
    @IBOutlet weak var stackViewBottom: UIStackView!
    // ⚠️1 = Top    ⚠️2 = Bottom    ⚠️L = Left    ⚠️R = Right
    //Bottom Left squareView
    @IBOutlet weak var squareViewL2: UIView!
    //Bottom Left imageView
    @IBOutlet weak var imageViewL2: UIImageView!
    //Bottom Left button
    @IBOutlet weak var pickImageButtonL2: UIButton!
    //Bottom Right squareVIew
    @IBOutlet weak var squareViewR2: UIView!
    //Bottom Right imageView
    @IBOutlet weak var imageViewR2: UIImageView!
    //Bottom Right Button
    @IBOutlet weak var pickImageButtonR2: UIButton!
    
    //--------------------------------------------------
    // MARK: - @IBOutlets: LayoutButton
    //--------------------------------------------------
    //PORTRAIT MODE: ⚠️1 = Left   ⚠️2 = Center   ⚠️2 = Right
    //LANDSCAPE MODE: ⚠️1 = Top   ⚠️2 = Center   ⚠️2 = Bottom
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    
    
    //-------------------------------------------------
    // MARK: - Instances
    //-------------------------------------------------
    var imagePickerController = UIImagePickerController()
    
    //-------------------------------------------------
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
        
        // ====================================
        // MARK: Init Swipe Gesture
        // ====================================
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.upSwipe))
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
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
        
        //disabledButton(disabled: layoutButton1, enabled1: layoutButton2, enabled2: layoutButton3)
        displaysLayout(layoutStyle: .rectangularTopView)
        layoutButton1.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        layoutButton2.setImage(nil, for: .normal)
        layoutButton3.setImage(nil, for: .normal)

    }
    
    //center layoutButton in portrait and landscape mode
    @IBAction func layoutButton2Tapped(_ sender: UIButton) {
        
        //disabledButton(disabled: layoutButton2, enabled1: layoutButton1, enabled2: layoutButton3)
        displaysLayout(layoutStyle: .rectangularBottomView)
        layoutButton2.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        layoutButton1.setImage(nil, for: .normal)
        layoutButton3.setImage(nil, for: .normal)

    }
    
    //layoutButton is on the right in portrait mode ⚠️layoutButton is on the bottom in landscape mode⚠️
    @IBAction func layoutButton3Tapped(_ sender: UIButton) {
        
        //disabledButton(disabled: layoutButton3, enabled1: layoutButton1, enabled2: layoutButton2)
        displaysLayout(layoutStyle: .squareView)
        layoutButton3.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        layoutButton1.setImage(nil, for: .normal)
        layoutButton2.setImage(nil, for: .normal)

    }
    
    //--------------------------------------------------
    // MARK: - Image Picker Buttons @IBAction
    //-------------------------------------------------
    
    // method that manages the action when the button L1 is clicked
    @IBAction func imagePickerL1ButtonTapped(_ sender: UIButton) {
        pickImageButtonL1.isSelected = true
        pickImage()
    }
    // method that manages the action when the button L2 is clicked
    @IBAction func imagePickerButtonL2Tapped(_ sender: UIButton) {
        pickImageButtonL2.isSelected = true
        pickImage()
    }
    // method that manages the action when the button R1 is clicked
    @IBAction func imagePickerButtonR1Tapped(_ sender: UIButton) {
        pickImageButtonR1.isSelected = true
        pickImage()
    }
    // method that manages the action when the button R2 is clicked
    @IBAction func imagePickerButtonR2Tapped(_ sender: UIButton) {
        pickImageButtonR2.isSelected = true
        pickImage()
    }
    
    //-----------------------------------------------------
    // MARK: - Settings
    //-----------------------------------------------------
    
    //method that displays the chosen layout style
    func displaysLayout(layoutStyle: Layout) {
        
        switch layoutStyle {
            
        case .rectangularBottomView:
            currentLayout(layoutStyle: .rectangularBottomView)
        case .rectangularTopView:
            currentLayout(layoutStyle: .rectangularTopView)
        case .squareView:
            currentLayout(layoutStyle: .squareView)
            
        }
    }
    
    // disable a button after clicking it. this method is not used by default in the program
    /*func disabledButton(disabled: UIButton, enabled1: UIButton, enabled2: UIButton) {
        disabled.isEnabled = false
        enabled1.isEnabled = true
        enabled2.isEnabled = true
    }
    */
    
    //method which parameters the different layout style cases
    func currentLayout(layoutStyle: Layout) {
        
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
    // ====================================
    // MARK - Swipe Gesture Method
    // ====================================
    @objc func upSwipe() {

    }
}
    // ====================================
    // MARK - Extension
    // ====================================
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // ====================================
    // MARK - Import Image for Album
    // ====================================
    
    // method that configures the image picker controller and presents it
    func pickImage() {
        
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = false
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    // recover the image to assign it to the corresponding view image according to the button that is selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if pickImageButtonL1.isSelected == true {
            imageViewL1.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            pickImageButtonL1.isSelected = false
            print("1")
        }
        if pickImageButtonL2.isSelected == true {
            imageViewL2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            pickImageButtonL2.isSelected = false
            print("2")
        }
        if pickImageButtonR1.isSelected == true {
        imageViewR1.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
            pickImageButtonR1.isSelected = false
            print("3")
        }
       if pickImageButtonR2.isSelected == true {
            self.imageViewR2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            pickImageButtonR2.isSelected = false
            print("4")
        }
        self.dismiss(animated: true, completion: nil)
    }
    // method used to cancel the choice of the image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickImageButtonL1.isSelected = false
        pickImageButtonL2.isSelected = false
        pickImageButtonR1.isSelected = false
        pickImageButtonR2.isSelected = false
        self.dismiss(animated: true, completion: nil)
    }
}
