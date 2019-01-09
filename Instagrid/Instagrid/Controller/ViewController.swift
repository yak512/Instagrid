//
//  ViewController.swift
//  Instagrid
//
//  Created by BOUHADEB Yacoub on 23/12/2018.
//  Copyright © 2018 BOUHADEB Yacoub. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var viewToShare: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let upSwipe = UISwipeGestureRecognizer(target: self, action:#selector(swipeAndShare(swipe :)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    
   @objc func swipeAndShare(swipe: UISwipeGestureRecognizer) {
        print("OKKKKKKKKKKKKKKK")
    UIGraphicsBeginImageContext(viewToShare.frame.size)
    viewToShare.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    let acivityViewController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
    present(acivityViewController, animated: true, completion: nil)
    }
    
    var subButton: UIButton?
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        subButton!.setImage(image, for: .normal)
        subButton?.imageView?.contentMode = .scaleAspectFill
        subButton?.clipsToBounds = true
        dismiss(animated:true, completion: nil)
    }

    @IBOutlet weak var form1: UIButton!
    
    
    func newButton() -> UIButton {
    let image = UIImage(named: "Combined Shape")
    let newButton = UIButton()
    newButton.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    newButton.setImage(image, for: .normal)
    newButton.addTarget(self, action: #selector(self.loadImageButtonTapped(sender:)), for: .touchUpInside)
    return newButton
    }
    
    private func whichForm() {
        
    }

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
    
    @IBOutlet weak var form2: UIButton!
    
    @IBOutlet weak var form3: UIButton!
    
    @IBAction func butt1x2(_ sender: Any) {
        let image = UIImage(named: "Selected")
        form2.setImage(nil, for: .normal)
        form3.setImage(nil, for: .normal)
        form1.setImage(image, for: .normal)
        clearViews()
        topStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
    }
   
    
    @IBAction func butt2x1(_ sender: Any) {
        
        let image = UIImage(named: "Selected")
        form2.setImage(image, for: .normal)
        form3.setImage(nil, for: .normal)
        form1.setImage(nil, for: .normal)
        clearViews()
        topStackView.addArrangedSubview(newButton())
        topStackView.addArrangedSubview(newButton())
        botStackView.addArrangedSubview(newButton())
    }
    
    @IBAction func butt2x2(_ sender: Any) {
        
        let image = UIImage(named: "Selected")
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

