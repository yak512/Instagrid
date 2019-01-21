//
//  ViewController.swift
//  Instagrid
//
//  Created by BOUHADEB Yacoub on 23/12/2018.
//  Copyright © 2018 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var viewToShare: UIView!
    @IBOutlet weak var instagrdLogo: UILabel!
    @IBOutlet weak var swipeImage: UIImageView!
    @IBOutlet weak var swipeText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let upSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipeAndShare(swipe :)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipeAndShare(swipe :)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // This function tell use what is the orientation of the Device
    private func whichOrientation() -> Bool {
        if UIDevice.current.orientation.isPortrait {
            return true
        } else {
            return false
        }
    }
    
    // This function do the animation when whant to share the collage
    private func animation() {
        UIView.animate(withDuration: 0.6, animations: {self.viewToShare.transform = CGAffineTransform(translationX: 0, y: -800)})
        UIView.animate(withDuration: 1.4, animations: {self.viewToShare.transform = CGAffineTransform(translationX: 0, y: 0)})
        UIView.animate(withDuration: 0.6, animations: {self.swipeImage.transform = CGAffineTransform(translationX: 0, y: -800)})
        UIView.animate(withDuration: 1.4, animations: {self.swipeImage.transform = CGAffineTransform(translationX: 0, y: 0)})
        UIView.animate(withDuration: 0.6, animations: {self.swipeText.transform = CGAffineTransform(translationX: 0, y: -800)})
        UIView.animate(withDuration: 1.4, animations: {self.swipeText.transform = CGAffineTransform(translationX: 0, y: 0)})
        UIGraphicsBeginImageContext(viewToShare.frame.size)
        UIView.animate(withDuration: 1, animations: {self.instagrdLogo.transform = CGAffineTransform(translationX: 0, y: -800)})
        UIView.animate(withDuration: 1.4, animations: {self.instagrdLogo.transform = CGAffineTransform(translationX: 0, y: 0)})
    }
    
    //This function let us share the collage
    @objc func swipeAndShare(swipe: UISwipeGestureRecognizer) {
        
        
        if (swipe.direction == .up && whichOrientation() == true) || (swipe.direction == .left && whichOrientation() == false){
            animation()
            UIGraphicsBeginImageContext(viewToShare.frame.size)
            viewToShare.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            let acivityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
            present(acivityViewController, animated: true, completion: nil)
        }
    }
    
    var subButton: UIButton?
    
    //This function let open the photo library of the phone
    @objc func loadImageButtonTapped(sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            subButton = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //This function let us pick a photo from the photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        subButton!.setImage(image, for: .normal)
        subButton?.imageView?.contentMode = .scaleAspectFill
        subButton?.clipsToBounds = true
        dismiss(animated:true, completion: nil)
    }
    
    
    
    // This function creat new button
    func newButton() -> UIButton {
        let image = UIImage(named: "Combined Shape")
        let newButton = UIButton()
        newButton.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        newButton.setImage(image, for: .normal)
        newButton.addTarget(self, action: #selector(self.loadImageButtonTapped(sender:)), for: .touchUpInside)
        newButton.pulsate()
        return newButton
    }
    
    //This function clear the view of the collage so we can choose another forml of collage
    func clearViews() {
        for subview in topStackView.subviews {
            subview.removeFromSuperview()
        }
        for subview in botStackView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    
    
    
    @IBOutlet weak var mainstack: UIStackView!
    
    var topStackView :UIStackView {
        return mainstack.arrangedSubviews.first as! UIStackView
    }
    
    var botStackView :UIStackView {
        return mainstack.arrangedSubviews.last as! UIStackView
    }
    
    
    
    
    @IBOutlet weak var form1: UIButton!
    
    @IBOutlet weak var form2: UIButton!
    
    @IBOutlet weak var form3: UIButton!
    
    let image = UIImage(named: "Selected")
    
    @IBAction func butt1x2(_ sender: Any) {
        
        form2.setImage(nil, for: .normal)
        form3.setImage(nil, for: .normal)
        form1.setImage(image, for: .normal)
        clearViews()
        topStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
    }
    
    @IBAction func butt2x1(_ sender: Any) {
        
        form2.setImage(image, for: .normal)
        form3.setImage(nil, for: .normal)
        form1.setImage(nil, for: .normal)
        clearViews()
        topStackView.addArrangedSubview(newButton())
        topStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
    }
    
    @IBAction func butt2x2(_ sender: Any) {
        
        form2.setImage(nil, for: .normal)
        form3.setImage(image, for: .normal)
        form1.setImage(nil, for: .normal)
        clearViews()
        topStackView.addArrangedSubview(newButton())
        topStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
        
        
    }
}

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.5
        pulse.toValue = 0.80
        pulse.autoreverses = true
        pulse.repeatCount = 0.7
        pulse.initialVelocity = 0.9
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
