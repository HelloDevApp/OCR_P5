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
    // MARK: - @IBOutlets:
    //--------------------------------------------------
    
    //Global StackView
    @IBOutlet weak var squareViewMiddle: UIView!
    
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
    
    //PORTRAIT MODE: ⚠️1 = Left   ⚠️2 = Center   ⚠️2 = Right
    //LANDSCAPE MODE: ⚠️1 = Top   ⚠️2 = Center   ⚠️2 = Bottom
    @IBOutlet weak var layoutButton1: UIButton!
    @IBOutlet weak var layoutButton2: UIButton!
    @IBOutlet weak var layoutButton3: UIButton!
    
    //-------------------------------------------------
    // MARK: - Instances
    //-------------------------------------------------
    
    let swipeUp = UISwipeGestureRecognizer()
    let swipeLeft = UISwipeGestureRecognizer()
    var imagePickerController = UIImagePickerController()
    
    //-------------------------------------------------
    // MARK: - Properties
    //-------------------------------------------------
    
    var currentLayout: Layout = .rectangularBottomView
    var readyToShare = false
    var imageToShare: UIImage?
    
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
    
    //--------------------------------------------------
    // MARK: - Layout Buttons @IBAction
    //-------------------------------------------------
    
    //layoutButton is on the left in portrait mode ⚠️layoutButton is on the top in landscape mode⚠️
    @IBAction func layoutButton1Tapped(_ sender: UIButton) {
        checkImagePickedIsComplete(layoutStyle: .rectangularTopView)
        checkReadyToShareForEnabledSwipe()
        displaysLayout(layoutStyle: .rectangularTopView)
        layoutButton1.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        layoutButton2.setImage(nil, for: .normal)
        layoutButton3.setImage(nil, for: .normal)
    }
    
    //center layoutButton in portrait and landscape mode
    @IBAction func layoutButton2Tapped(_ sender: UIButton) {
        checkImagePickedIsComplete(layoutStyle: .rectangularBottomView)
        checkReadyToShareForEnabledSwipe()
        displaysLayout(layoutStyle: .rectangularBottomView)
        layoutButton2.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        layoutButton1.setImage(nil, for: .normal)
        layoutButton3.setImage(nil, for: .normal)
    }
    
    //layoutButton is on the right in portrait mode ⚠️layoutButton is on the bottom in landscape mode⚠️
    @IBAction func layoutButton3Tapped(_ sender: UIButton) {
        checkImagePickedIsComplete(layoutStyle: .squareView)
        checkReadyToShareForEnabledSwipe()
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
    // MARK: - Settings Layout
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
    
    //method which parameters the different layout style cases
    func currentLayout(layoutStyle: Layout) {
        
        switch layoutStyle {
            
        case .rectangularBottomView:
            currentLayout = .rectangularBottomView
            squareViewR2.isHidden = true
            imageViewR2.isHidden = true
            squareViewR1.isHidden = false
            imageViewR1.isHidden = false
        case .rectangularTopView:
            currentLayout = .rectangularTopView
            squareViewR1.isHidden = true
            imageViewR1.isHidden = true
            squareViewR2.isHidden = false
            imageViewR2.isHidden = false
        case .squareView:
            currentLayout = .squareView
            squareViewR1.isHidden = false
            imageViewR1.isHidden = false
            squareViewR2.isHidden = false
            imageViewR2.isHidden = false
        }
    }
    
    // checks that all pictures have been imported
    func checkImagePickedIsComplete(layoutStyle: Layout) {

        switch layoutStyle {
            
        case .rectangularBottomView:
            if imageViewL1.image != nil && imageViewL2.image != nil && imageViewR1.image != nil {
                hideButton(yes: true)
                checkReadyToShareForEnabledSwipe()
            } else {
                hideButton(yes: false)
            }
        case .rectangularTopView:
            if imageViewL1.image != nil && imageViewL2.image != nil && imageViewR2.image != nil {
                hideButton(yes: true)
                checkReadyToShareForEnabledSwipe()
            } else {
                hideButton(yes: false)
            }
        case .squareView:
            if imageViewL1.image != nil && imageViewL2.image != nil && imageViewR1.image != nil && imageViewR2.image != nil {
                hideButton(yes: true)
                checkReadyToShareForEnabledSwipe()
            } else {
                hideButton(yes: false)
            }
        }
    }
    
    // hide buttons for create context graphic
    func hideButton(yes: Bool) {
        if yes == true {
            pickImageButtonL1.isHidden = true
            pickImageButtonL2.isHidden = true
            pickImageButtonR1.isHidden = true
            pickImageButtonR2.isHidden = true
            readyToShare = true
        } else {
            pickImageButtonL1.isHidden = false
            pickImageButtonL2.isHidden = false
            pickImageButtonR1.isHidden = false
            pickImageButtonR2.isHidden = false
            readyToShare = false
        }
    }
    
    // checks that the image is ready to share to activate the swipe that corresponds to the orientation
    func checkReadyToShareForEnabledSwipe() {
        if readyToShare {
            initSwipeGesture()
        } else {
            self.view.removeGestureRecognizer(swipeUp)
            self.view.removeGestureRecognizer(swipeLeft)
        }
    }
    
    // ====================================
    // MARK: Swipe Gesture Settings
    // ====================================
    
    // allows you to configure the swipe and add or remove it to the view
    func initSwipeGesture() {
        swipeUp.direction = .up
        swipeLeft.direction = .left
        if UIDevice.current.orientation == .portrait {
            swipeUp.addTarget(self, action: #selector(swipeUpAction))
            self.view.removeGestureRecognizer(swipeLeft)
            self.view.addGestureRecognizer(swipeUp)
        } else {
            swipeLeft.addTarget(self, action: #selector(swipeLeftAction))
            self.view.removeGestureRecognizer(swipeUp)
            self.view.addGestureRecognizer(swipeLeft)
        }
    }
    
    // detects each time the device changes orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        checkReadyToShareForEnabledSwipe()
    }
    
    // ====================================
    // MARK: - Swipe Gesture Action
    // ====================================
    
    @objc func swipeUpAction() {
        guard readyToShare else {
            return
        }
        createImageToShare()
        shareImage()
    }
    
    @objc func swipeLeftAction() {
        guard readyToShare else {
            return
        }
        createImageToShare()
        shareImage()
    }
    
    // ====================================
    // MARK: - Share Image Method
    // ====================================
    
    //allows you to create the image to share and assign it to the imageToShare variable
    func createImageToShare() {
        UIGraphicsBeginImageContext(squareViewMiddle.frame.size)
        squareViewMiddle.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        imageToShare = viewImage
        UIGraphicsEndImageContext()
    }
    
    // adds the image to share, creates the UIActivityViewController and then presents it
    func shareImage() {
        var itemToShare = [UIImage]()
        if imageToShare != nil {
        itemToShare.append(imageToShare!)
        }
        let activityViewController = UIActivityViewController(activityItems:itemToShare, applicationActivities: nil)
        activityViewController.modalPresentationStyle = .overCurrentContext
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
            self.reset()
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    func reset() {
        imageViewL1.image = nil
        imageViewL2.image = nil
        imageViewR1.image = nil
        imageViewR2.image = nil
        hideButton(yes: false)
        imageToShare = nil
        readyToShare = false
    }
}

    // ====================================
    // MARK: - Extension
    // ====================================

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // ====================================
    // MARK: Import Image for Album
    // ====================================
    
    // method that configures the image picker controller and presents it
    func pickImage() {
        self.imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .overCurrentContext
        self.imagePickerController.allowsEditing = false
        self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // recover the image to assign it to the corresponding view image according to the button that is selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if pickImageButtonL1.isSelected == true {
            imageViewL1.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            pickImageButtonL1.isSelected = false
        }
        if pickImageButtonL2.isSelected == true {
            imageViewL2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            pickImageButtonL2.isSelected = false
        }
        if pickImageButtonR1.isSelected == true {
            imageViewR1.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            pickImageButtonR1.isSelected = false
        }
       if pickImageButtonR2.isSelected == true {
            self.imageViewR2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            pickImageButtonR2.isSelected = false
        }
        checkImagePickedIsComplete(layoutStyle: currentLayout)
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
