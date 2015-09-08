//
//  SettingsViewController.swift
//  tippp
//
//  Created by Marco Sgrignuoli on 9/8/15.
//  Copyright (c) 2015 Optimizely. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultTip = defaults.integerForKey("tipAmountIndex")
        if (defaultTip >= 0) {
            tipControl.selectedSegmentIndex = defaultTip
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tipSelected(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "tipAmountIndex")
        defaults.synchronize()
    
    }

    @IBAction func unwindSettings(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
