//
//  ViewController.swift
//  CardPayment
//
//  Created by admin on 01/03/18.
//  Copyright © 2018 Vishal. All rights reserved.
//

import UIKit
import MonthYearPicker
class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    
    @IBOutlet var displayCardName: UILabel!
    @IBOutlet var cardNameTextField: UITextField!
    
    
    @IBOutlet var cardNumberTextField: UITextField!
    @IBOutlet var cardNo1TextField: UITextField!
    @IBOutlet var cardNo2TextField: UITextField!
    @IBOutlet var cardNo3TextField: UITextField!
    @IBOutlet var cardNo4TextField: UITextField!
    
    @IBOutlet var expireDateLabel: UILabel!
    @IBOutlet var expireDateTextField: UITextField!
    
    @IBOutlet var cvvLabel: UITextField!
    @IBOutlet var cvvTextField: UITextField!
    
    @IBOutlet var datePickerPopUP: UIView!
    @IBOutlet var datePickerView: UIView!
    
    var FlipFromLeft : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstView.layer.cornerRadius = 10.0
        self.firstView.clipsToBounds = true
        self.firstView.layer.borderWidth = 2.0
        self.firstView.layer.borderColor = UIColor.white.cgColor
        self.firstView.layer.shadowRadius = 1
        self.firstView.layer.shadowOffset = CGSize(width: -1, height: -1)
        self.firstView.layer.shadowOpacity = 0.5
        
        self.secondView.layer.cornerRadius = 10.0
        self.secondView.clipsToBounds = true
        
        self.cardNameTextField.delegate = self
        self.cardNameTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                            for: UIControlEvents.editingChanged)
        
        self.cardNumberTextField.delegate = self
        self.cardNumberTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                                         for: UIControlEvents.editingChanged)
        
        self.cvvTextField.delegate = self
        self.cvvTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                                           for: UIControlEvents.editingChanged)

        let picker = MonthYearPickerView(frame: CGRect(x: 0, y: 0, width: datePickerView.bounds.width, height: datePickerView.bounds.height))
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        self.datePickerView.addSubview(picker)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Button Click Events
    @IBAction func payButtonClick(_ sender: UIButton) {
        if FlipFromLeft == true {
            UIView.transition(with: self.firstView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
                UIView.transition (with: self.secondView, duration: 1.0, options: .transitionFlipFromLeft, animations: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { self.secondView.isHidden = false;
                        self.firstView.isHidden = true;
                    })
                })
            })
            self.FlipFromLeft = false
        }
        else{
            UIView.transition(with: self.secondView, duration: 1.0, options: .transitionFlipFromRight, animations: {
                UIView.transition (with: self.firstView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.firstView.isHidden = false;
                        self.secondView.isHidden = true;
                    })
                })
            })
            self.FlipFromLeft = true
        }
    }
    
    @objc func dateChanged(_ picker: MonthYearPickerView) {
        print("date changed: \(picker.date)")
        let date = picker.date
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        let str = "\(year)"
        let result = String(str.dropFirst(2))
        
        self.expireDateLabel.text = "\(month)/\(result)"
        self.expireDateTextField.text = "\(month)/\(result)"
        
    }
    
    @IBAction func datePickerDoneButtonClick(_ sender: UIButton) {
        self.datePickerPopUP.isHidden = true
    }
    
    
    @IBAction func dateButtonClick(_ sender: UIButton) {
        self.datePickerPopUP.isHidden = false
    }
    
    //MARK: TextField Delegate Method
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.cardNameTextField {
            self.displayCardName.text = textField.text
        }
        
        if textField == self.cardNumberTextField {
            
            if (textField.text?.count)! < 5 {
                self.cardNo1TextField.text = textField.text
            }
            else if (textField.text?.count)! > 4 && (textField.text?.count)! < 9 {
                let str = textField.text
                let result = String(str!.dropFirst(4))
                self.cardNo2TextField.text = result
                print("Card No 2", result)
            }
            else if (textField.text?.count)! > 8 && (textField.text?.count)! < 13 {
                let str = textField.text
                let result = String(str!.dropFirst(8))
                self.cardNo3TextField.text = result
                print("Card No 3",result)
            }
            else if  (textField.text?.count)! > 12 && (textField.text?.count)! < 17 {
                let str = textField.text
                let result = String(str!.dropFirst(12))
                let trimmedString = result.trimmingCharacters(in: .whitespaces)
                self.cardNo4TextField.text = trimmedString
                print("Card No 4",result)
            }
            
        }
        
        if textField == self.cvvTextField {
            self.cvvLabel.text = self.cvvTextField.text
        }
    }
}

