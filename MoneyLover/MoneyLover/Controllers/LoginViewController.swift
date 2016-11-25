//
//  ViewController.swift
//  MoneyLover
//
//  Created by Phùng Tùng on 11/22/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var scrollView: UIScrollView!
    @IBOutlet weak var loginFBButton: UIButton!
    @IBOutlet weak var loginGoogleButton: UIButton!
    @IBOutlet weak var signinSignupEmailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let scrollViewRect = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: (self.view.bounds.size.height * 2) / 3)
        self.scrollView = UIScrollView(frame: scrollViewRect)
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSize(width: scrollViewRect.size.width * 4.0, height: scrollViewRect.size.height)
        self.view.addSubview(scrollView)
        var imageViewRect = scrollViewRect
        var labelRect = CGRect(x: 0, y: imageViewRect.size.height - 40, width: imageViewRect.size.width, height: 30)
        let splashScreenData = SplashScreenData()
        for page in splashScreenData.dataPage {
            let textLabel = UILabel(frame: labelRect)
            textLabel.font = UIFont(name: textLabel.font?.fontName ?? "", size: 12)
            textLabel.textAlignment = NSTextAlignment.Center
            textLabel.numberOfLines = 0
            textLabel.textColor = UIColor.whiteColor()
            textLabel.text = page.description
            let imageViewPage = self.createImageView(UIImage(named: page.imageName), frame: imageViewRect)
            scrollView.backgroundColor = UIColor(red: 0.0/255.0, green: 199.0/255.0, blue: 83.0/255, alpha: 1)
            self.scrollView.addSubview(textLabel)
            self.scrollView.addSubview(imageViewPage)
            imageViewRect.origin.x += imageViewRect.size.width
            labelRect.origin.x += labelRect.size.width
        }
        loginFBButton?.round(5, borderWith: 1, borderColor: UIColor.blueColor().CGColor)
        loginGoogleButton?.round(5, borderWith: 1, borderColor: UIColor.redColor().CGColor)
        signinSignupEmailButton?.round(5, borderWith: 1, borderColor: UIColor.grayColor().CGColor)
    }
    
    @IBAction func loginFBAction(sender: AnyObject) {
    }
    
    @IBAction func LoginGoogleAction(sender: AnyObject) {
    }
    
    @IBAction func signinSignupEmailAction(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func createImageView(paramImage: UIImage?, frame: CGRect) -> UIImageView {
        let result = UIImageView(frame: frame)
        result.contentMode = UIViewContentMode.ScaleAspectFit
        result.image = paramImage
        return result
    }
}