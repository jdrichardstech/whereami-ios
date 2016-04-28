//
//  WAQuestionViewController.swift
//  WhereAmI
//
//  Created by Devinci on 4/20/16.
//  Copyright © 2016 JDRichardsTech. All rights reserved.
//

import UIKit
import Alamofire

class WASingleQuestionViewController: WAViewController {
	
	
	var imageView:UIImageView!
	var choiceOneButton:UIButton!
	var choiceTwoButton:UIButton!
	var choiceThreeButton:UIButton!
	var choiceFourButton:UIButton!
	var rightButtonNum: Int!
	var question: WAQuestion!
	var buttons = Array<UIButton>()
	var array = Array<Bool>()
	
	
	
	
	
	
	
	
	//overriding the initializers because of lazy loading
	required init?(coder aDecoder: NSCoder){
		super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		self.title = "Questions"
		self.tabBarItem.image = UIImage(named: "question.png")
	}
	
	
	
	override func loadView() {
		let frame = UIScreen.mainScreen().bounds
		let view = UIView(frame: frame)
		view.backgroundColor = UIColor.whiteColor()
		
		
		let padding = CGFloat(6)
		let dimen = frame.size.width
		var y = dimen
		let height = CGFloat(dimen/7.5)
		//let width = dimen-2*padding
		let offscreen = frame.size.height
		//let white = UIColor.whiteColor()
		
		let answerIndex = Int(self.randomNumber(4))
		print(answerIndex)
		
		var options = Array<String>()
		options.appendContentsOf(self.question.options)
		options.insert("answer", atIndex: answerIndex)
		
		self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: dimen, height: 300))
		self.imageView.image = self.question.imageData
		
		
		
		
		view.addSubview(imageView)
		
		
		for i in 0..<4{
			let btn = UIButton(type: .Custom)
			btn.tag = Int(y)
			btn.frame = CGRect(x: padding, y: offscreen, width: dimen-2*padding, height: height)
			
			btn.backgroundColor = UIColor.clearColor()
			
			btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
			
			btn.setTitle("Button", forState: .Normal)
			btn.titleLabel?.textAlignment = .Center
			btn.titleLabel?.font = UIFont(name: "Thonburi", size: 15)
			btn.layer.cornerRadius = 10
			btn.layer.borderWidth = 1
			btn.layer.masksToBounds = false
			//btn.titleLabel?.numberOfLines = 0;
			//btn.titleLabel?.adjustsFontSizeToFitWidth = true
			btn.layer.borderColor = UIColor.blackColor().CGColor
			let text = (i==answerIndex) ? self.question.answer : options[i]
			
			btn.setTitle(text, forState: .Normal)
			btn.addTarget(self, action: #selector(WASingleQuestionViewController.selectOption(_:)), forControlEvents:.TouchUpInside)
			view.addSubview(btn)
			self.buttons.append(btn)
			y+=btn.frame.size.height + padding
			
		print("Tag: \(btn.tag)")
		}
		
		

		self.view = view
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		for i in 0..<self.buttons.count{
			
			
//			UIView.animateWithDuration(1.24,
//			                           delay: 0,
//			                           options: .CurveEaseInOut,
//			                           animations: {
//										let btn = self.buttons[i]
//										var btnFrame = btn.frame
//										btnFrame.origin.y = CGFloat(btn.tag)
//										btn.frame = btnFrame
//				},
//			                           completion: nil)
			UIView.animateWithDuration(1.35,
			                           delay: (0.5+Double(i)*0.1),
			                           usingSpringWithDamping: 0.5,
			                           initialSpringVelocity: 0.0,
			                           options: .CurveEaseInOut,
			                           animations: {
											let btn = self.buttons[i]
											var btnFrame = btn.frame
											btnFrame.origin.y = CGFloat(btn.tag)
											btn.frame = btnFrame
										},
			                           completion: nil)
		}
		
	
	}
	
	override func viewWillAppear(animated: Bool){
		super.viewWillAppear(animated)
		self.navigationController?.navigationBarHidden = true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
	}
	
	// MARK: - My Functions
	
	

	
	func randomNumber(max: Int) ->UInt32{
		let i = arc4random() % UInt32(max)
		//print("Random \(i)")
		return i
		
	}
	
	func selectOption(btn:UIButton){
		let selectedOption = btn.titleLabel!.text!
		
		if(selectedOption == self.question.answer){
		
		 self.question.status = 1
			print("Correct")
		}
		else{
			print("Incorrect")
			
			self.question.status = 2
			
		}
		self.navigationController?.popViewControllerAnimated(true)
		
	}
	
}