//
//  ViewController.swift
//  MultiLanguage
//
//  Created by bruce on 16/3/31.
//  Copyright © 2016年 ZouLiangming. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commonInit()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func commonInit() {
        self.changeButton.setTitle(LocalizedString("Change"), forState: .Normal)
        self.helloLabel.text = LocalizedString("Hello")
    }
    
    @IBAction func changeButtonPressed(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "中文","English")
        actionSheet.showInView(self.view)
    }

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            InternationalControl.setCurrentLanguage(.SimplifiedChinese)
        } else if buttonIndex == 2 {
            InternationalControl.setCurrentLanguage(.English)
        }
        self.commonInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
