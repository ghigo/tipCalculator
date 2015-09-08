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
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"onApplicationWillResignActive", name:UIApplicationWillResignActiveNotification, object: nil)
        
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
        var lastActive = defaults.objectForKey("lastActive") as! NSDate!
        var elapsed = NSDate().timeIntervalSinceDate(lastActive)
        if (elapsed < 600) {
            println(defaults.stringForKey("billValue"))
            billField.text = defaults.stringForKey("billValue")
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
    
    func onApplicationWillResignActive() {
        var now = NSDate()
        var defaults = NSUserDefaults.standardUserDefaults()
        var bill = NSString(string: billField.text).doubleValue
        println(bill)
        defaults.setObject(NSString(string: billField.text), forKey:"billValue")
        defaults.setObject(now, forKey:"lastActive")
        defaults.synchronize()
    }
    
    func onApplicationDidBecomeActive() {

        
    }

}

