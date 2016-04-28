//
//  WARegisterViewController.swift
//  WhereAmI
//
//  Created by Devinci on 4/20/16.
//  Copyright © 2016 dankwon. All rights reserved.
//

import UIKit
import Alamofire

class WARegisterViewController: WAViewController, UITextFieldDelegate {
    
    var textFields = Array<UITextField>()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Profile"
        self.tabBarItem.image = UIImage(named: "profile.png")

    }

    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.greenColor()
        
        let fields = ["Name", "Username", "Password"]
        let padding = CGFloat(20)
        let width = frame.size.width-2*padding
        let height = CGFloat(32)
        var y = CGFloat(72)
        
        for field in fields {
            let textfield = UITextField(frame: CGRect(x: padding, y: y, width: width, height: height))
            textfield.delegate = self
            textfield.placeholder = field
            textfield.borderStyle = .RoundedRect
            view.addSubview(textfield)
            textFields.append(textfield)
            y += height+padding
        }
        
        let btnRegister = UIButton(frame: CGRect(x: padding, y: y, width: width, height: 44))
        btnRegister.backgroundColor = UIColor.lightGrayColor()
        btnRegister.setTitle("Sign Up", forState: .Normal)
        btnRegister.addTarget(self, action: #selector(WARegisterViewController.registerUser(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(btnRegister)
            
        self.view = view
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - My shit
    func registerUser(btn: UIButton){
        
        var profileInfo = Dictionary<String, AnyObject>()
        for field in self.textFields {
            let fieldName = field.placeholder
            profileInfo[fieldName!.lowercaseString] = field.text
        }
        
        let name = profileInfo["name"] as? String
        let nameParts = name!.componentsSeparatedByString(" ")
        profileInfo["firstName"] = nameParts[0]
        if (nameParts.count > 1){
            profileInfo["lastName"] = nameParts[nameParts.count-1]
        }
        
        print("registerUser: \(profileInfo)")
//        let url = "http://jd-where-am-i.herokuapp.com/api/question"
		let url = Constants.baseUrl + "api/profile"
        Alamofire.request(.POST, url, parameters: profileInfo).responseJSON { response in
            if let JSON = response.result.value as? Dictionary<String, AnyObject>{
                print("\(JSON)")
                
                
            }
            
        }
        
    }
    
    // MARK: - TextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    

    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
