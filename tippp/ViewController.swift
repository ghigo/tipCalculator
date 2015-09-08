//
//  ViewController.swift
//  tippp
//
//  Created by Marco Sgrignuoli on 9/3/15.
//  Copyright (c) 2015 Optimizely. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.text = ""
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        // Load defaults
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultTip = defaults.integerForKey("tipAmountIndex")
        if (defaultTip >= 0) {
            tipControl.selectedSegmentIndex = defaultTip
        }
        
        updateValues()
    }
    
    func updateValues() {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

}

