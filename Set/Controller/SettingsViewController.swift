//
//  SettingsViewController.swift
//  Set
//
//  Created by Tommy Howell on 9/25/18.
//  Copyright © 2018 Tommy Howell. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // Override the iPhone behavior that presents a popover as fullscreen
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func SaveButtonTapped(_ sender: UIBarButtonItem) {
        SettingsSingleton.settingsSingleton.replaceColors(with: [colorOne, colorTwo, colorThree])
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        colorButtonOne.setTitleColor(colorOne, for: UIControl.State())
        colorButtonTwo.setTitleColor(colorTwo, for: UIControl.State())
        colorButtonThree.setTitleColor(colorThree, for: UIControl.State())
    }
    
    @IBOutlet weak var colorButtonOne: UIButton!
    @IBOutlet weak var colorButtonTwo: UIButton!
    @IBOutlet weak var colorButtonThree: UIButton!
    var colorOne: UIColor = SettingsSingleton.settingsSingleton.getColors()[0]
    var colorTwo: UIColor = SettingsSingleton.settingsSingleton.getColors()[1]
    var colorThree: UIColor = SettingsSingleton.settingsSingleton.getColors()[2]
    var buttonToSet: Int = 0
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 284, height: 446)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        buttonToSet = sender.tag
        present(popoverVC, animated: true, completion: nil)
    }
    
    func setButtonColor(_ color: UIColor) {
        switch buttonToSet {
        case 0:
            colorButtonOne.setTitleColor(color, for: UIControl.State())
            colorOne = color
        case 1:
            colorButtonTwo.setTitleColor(color, for: UIControl.State())
            colorTwo = color
        case 2:
            colorButtonThree.setTitleColor(color, for: UIControl.State())
            colorThree = color
        default:
            break
        }
    }
}
