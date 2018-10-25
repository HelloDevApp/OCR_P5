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
// contains the different styles of displaying elements in the application
enum Layout {
    case rectangularBottomView
    case rectangularTopView
    case squareView
}

class ViewController: UIViewController {

    //--------------------------------------------------
    // MARK: - @IBOutlets:
    //--------------------------------------------------
    
    // View Middle
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
    // creation of a gesture
    let swipeUp = UISwipeGestureRecognizer()
    let swipeLeft = UISwipeGestureRecognizer()
    // creation of the controller that will configure the way to import images
    var imagePickerController = UIImagePickerController()
    
    //-------------------------------------------------
    // MARK: - Properties
    //-------------------------------------------------
    
    // variable that contains the current layout of the interface elements
    var currentLayout: Layout = .rectangularBottomView
    // is used to check if the sharing of the image is ready
    var readyToShare = false
    // contains the final image that will be used for sharing
    var imageToShare: UIImage?
    
    //--------------------------------------------------
    // MARK: - Standard Methods
    //-------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displaysLayout(layoutStyle: .rectangularBottomView)
    }
    
    //--------------------------------------------------
    // MARK: - Layout Buttons @IBAction
    //-------------------------------------------------
    
    //layoutButton is on the left in portrait mode ⚠️layoutButton is on the top in landscape mode⚠️
    @IBAction func layoutButton1Tapped(_ sender: UIButton) {
        updateLayoutAndAnimateIfCOmpleted(layoutStyle: .rectangularTopView, buttonImageSelected: layoutButton1, buttonsImageNil: [layoutButton2,layoutButton3])
    }
    
    //center layoutButton in portrait and landscape mode
    @IBAction func layoutButton2Tapped(_ sender: UIButton) {
        updateLayoutAndAnimateIfCOmpleted(layoutStyle: .rectangularBottomView, buttonImageSelected: layoutButton2, buttonsImageNil: [layoutButton1,layoutButton3])
    }
    
    //layoutButton is on the right in portrait mode ⚠️layoutButton is on the bottom in landscape mode⚠️
    @IBAction func layoutButton3Tapped(_ sender: UIButton) {
        updateLayoutAndAnimateIfCOmpleted(layoutStyle: .squareView, buttonImageSelected: layoutButton3, buttonsImageNil: [layoutButton1,layoutButton2])
    }
    // check if images picked is completed for hide buttons, active swipe (if images picked is completed) and display new layout style
    func updateLayoutAndAnimateIfCOmpleted(layoutStyle: Layout, buttonImageSelected: UIButton, buttonsImageNil: [UIButton]) {
        // ***hide button and enabled Swipe*** only if images Picked of layout is completed
        checkLayoutStyle(layoutStyle: layoutStyle)
        displaysLayout(layoutStyle: layoutStyle)
        buttonImageSelected.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        for button in buttonsImageNil {
            button.setImage(nil, for: .normal)
        }
        // animate only if images Picked of layout is completed
        animateView(view: squareViewMiddle)
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
            settingsLayout(layoutStyle: .rectangularBottomView)
        case .rectangularTopView:
            settingsLayout(layoutStyle: .rectangularTopView)
        case .squareView:
            settingsLayout(layoutStyle: .squareView)
        }
    }
    
    //method which parameters the different layout style cases
    func settingsLayout(layoutStyle: Layout) {
        
        switch layoutStyle {
            
        case .rectangularBottomView:
            currentLayout = .rectangularBottomView
            // only first element in arrays is equal to value
            hiddenViewsAndImageViewsForDisplayLayout(views: [squareViewR2,squareViewR1], imageViews: [imageViewR2,imageViewR1], value: true)
        case .rectangularTopView:
            currentLayout = .rectangularTopView
            // only first element in arrays is equal to value
            hiddenViewsAndImageViewsForDisplayLayout(views: [squareViewR1,squareViewR2], imageViews: [imageViewR1,imageViewR2], value: true)
        case .squareView:
            currentLayout = .squareView
            // only first element in arrays is equal to value
            hiddenViewsAndImageViewsForDisplayLayout(views: [squareViewL1,squareViewL2,squareViewR1,squareViewR2], imageViews: [imageViewL1,imageViewL2,imageViewR1,imageViewR2], value: false)
        }
    }
    // the value of the value parameter is inverted at each loop turn so that only the first object in an array takes the value value (only if the display style is different from.squareView)
    func hiddenViewsAndImageViewsForDisplayLayout(views: [UIView], imageViews: [UIImageView], value: Bool) {
       var value = value
        for view in views {
            view.isHidden = value
            if currentLayout != .squareView {
                value = !value
            }
        }
        for imageView in imageViews {
            imageView.isHidden = value
            if currentLayout != .squareView {
                value = !value
            }
        }
    }
    
    // checks that the imageViews of a layout contain an image for enabled swipe and hide buttons
    func checkLayoutStyle(layoutStyle: Layout) {

        switch layoutStyle {
            
        case .rectangularBottomView:
            // checks if the chosen layout is complete according to the parameters
            updateElementsIfLayoutIsComplete(imageViews: [imageViewL1, imageViewL2, imageViewR1])
        case .rectangularTopView:
            // checks if the chosen layout is complete according to the parameters
           updateElementsIfLayoutIsComplete(imageViews: [imageViewL1, imageViewL2, imageViewR2])
        case .squareView:
            // checks if the chosen layout is complete according to the parameters
            updateElementsIfLayoutIsComplete(imageViews: [imageViewL1, imageViewL2, imageViewR1, imageViewR2])
        }
    }
    // elements: hideButtons, enableSwipe and modify value of ReadyToShare (if completed layout import images)
    func updateElementsIfLayoutIsComplete(imageViews: [UIImageView]) {
        for imageview in imageViews {
            // if imageView.image is nil, the buttons are not hidden and readyToShare is 'false'
            guard imageview.image != nil else {
                hideButtons(buttons: [pickImageButtonL1,pickImageButtonL2,pickImageButtonR1,pickImageButtonR2], value: false)
                changeValueReadyToShare(value: false)
                return
            }
        }
        // if imageView.image in imageViews is not nil, buttons is hidden, readyToShare is 'true' and active swipe
        hideButtons(buttons: [pickImageButtonL1,pickImageButtonL2,pickImageButtonR1,pickImageButtonR2], value: true)
        changeValueReadyToShare(value: true)
        checkReadyToShareForEnabledSwipe()
    }
    // hide buttons for create context graphic
    func hideButtons(buttons: [UIButton], value: Bool) {
        for button in buttons {
            button.isHidden = value
        }
    }
    // change the value of the readyToShare property
    func changeValueReadyToShare(value: Bool) {
        readyToShare = value
    }
    
    // ====================================
    // MARK:-  Swipe Gesture Settings
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
    // checks that the image is ready to share to activate the swipe that corresponds to the orientation
    func checkReadyToShareForEnabledSwipe() {
        if readyToShare {
            initSwipeGesture()
        } else {
            self.view.removeGestureRecognizer(swipeUp)
            self.view.removeGestureRecognizer(swipeLeft)
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
    // method to call during a swipe up
    @objc func swipeUpAction() {
        guard readyToShare else {
            return
        }
        createImageToShare()
        shareImage()
    }
    //method to call during a swipe left
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
        // property that contains the graphic context (image to share)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        imageToShare = viewImage
        UIGraphicsEndImageContext()
    }
    
    // adds the image to share, creates the UIActivityViewController and then presents it
    func shareImage() {
        // table that contains the elements to share
        var itemToShare = [UIImage]()
        if imageToShare != nil {
        itemToShare.append(imageToShare!)
        }
        // create an activityViewController that allows you to configure the display of the sharing interface
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
    // allows you to reset the interface elements
    func reset() {
        deleteImageFromImageViews(imageViews: [imageViewL1,imageViewL2,imageViewR1,imageViewR2])
        hideButtons(buttons: [pickImageButtonL1,pickImageButtonL2,pickImageButtonR1,pickImageButtonR2], value: false)
        imageToShare = nil
        readyToShare = false
    }
    // allows you delete they images from imageViews
    func deleteImageFromImageViews(imageViews: [UIImageView]) {
        for imageView in imageViews {
            imageView.image = nil
        }
    }
    // ====================================
    // MARK: - Animations
    // ====================================
    // method that animates the apparition of an image by enlarging it
    func animateImageView(imageView: UIImageView) {
        UIView.animate(withDuration: 0.0, animations: {
            imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.5, animations: {
                imageView.transform = CGAffineTransform.identity
            })
        })
    }
    //method that allows an animation with a rotation of 720°degrees with a slowing effect at the end
    func animateView(view: UIView) {
        if readyToShare {
            UIView.animate(withDuration: 0.10, delay: 0.70, options: .curveLinear, animations: {
                view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }, completion: nil)

            UIView.animate(withDuration: 0.15, delay: 0.80, options: .curveLinear, animations: {
                view.transform = CGAffineTransform.identity
            })
        
            UIView.animate(withDuration: 0.20, delay: 0.95, options: .curveLinear, animations: {
                view.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }, completion: nil)

            UIView.animate(withDuration: 0.25, delay: 1.15, options: .curveLinear, animations: {
                view.transform = CGAffineTransform.identity
            })
        }
    }
}
    // ===============================================
    // MARK: - Import Image from Album device
    // ===============================================
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            updateImageView(button: pickImageButtonL1, imageView: imageViewL1, info: info)
        }
        if pickImageButtonL2.isSelected == true {
            updateImageView(button: pickImageButtonL2, imageView: imageViewL2, info: info)
        }
        if pickImageButtonR1.isSelected == true {
            updateImageView(button: pickImageButtonR1, imageView: imageViewR1, info: info)
        }
       if pickImageButtonR2.isSelected == true {
            updateImageView(button: pickImageButtonR2, imageView: imageViewR2, info: info)
        }
        checkLayoutStyle(layoutStyle: currentLayout)
        // only layout is completed
        animateView(view: squareViewMiddle)
        self.dismiss(animated: true, completion: nil)
    }
    // allows you to display the image imported by the user on the clicked button
    func updateImageView(button: UIButton, imageView: UIImageView, info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        animateImageView(imageView: imageView)
        button.isSelected = false
    }
    // method used to cancel the choice of the image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //we set the buttons.isSelected value to 'false'
        buttonIsSelected(buttons: [pickImageButtonL1,pickImageButtonL2,pickImageButtonR1,pickImageButtonR2], value: false)
        self.dismiss(animated: true, completion: nil)
    }
    // method used to give a value to several buttons
    func buttonIsSelected(buttons: [UIButton], value: Bool) {
        for button in buttons {
            button.isSelected = value
        }
    }
}
