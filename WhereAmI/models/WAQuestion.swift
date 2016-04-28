//
//  WAQuestion.swift
//  WhereAmI
//
//  Created by Devinci on 4/26/16.
//  Copyright © 2016 dankwon. All rights reserved.
//

import UIKit
import Alamofire

class WAQuestion: NSObject {

	var answer: String!
	var options:Array<String>!
	var image: String!
	var imageData: UIImage?
	var isFetching =  false
	var status = 0 // 0 = unanswered, 1=answered coreectly, 2=answered incorrectly
	
	
	
	func populate(info:Dictionary<String, AnyObject>){
		if let _answer = info["answer"]as? String{
			self.answer = _answer
		}
		
		if let _image = info["image"] as? String{
		
			self.image = _image
		}
		
		if let _options = info["options"] as? Array<String>{
			self.options = _options
		}
	
	}
	
	func fetchImage(){
		if(self.isFetching==true){
			return
		}
		
		if(self.image.characters.count == 0){
			return
		}
		
		
		let url = "https://media-service.appspot.com/site/images/"+self.image+"?crop=600"
		self.isFetching = true
		Alamofire.request(.GET, url, parameters: nil).response{(request,response,data,error) in
			self.isFetching = false
			if(error != nil){
				return
			}
			
			if(data != nil){
			self.imageData = UIImage(data: data!)
				
			let notification = NSNotification(name: "ImageDownloaded", object: nil,userInfo: nil)
			let notificationCenter = NSNotificationCenter.defaultCenter()
			notificationCenter.postNotification(notification)//brodcast notification
			}
		//print("image (self.imageData)")
		print("answer \(self.answer)")
			print("image \(self.imageData)")
		}
	}
	
	
}
