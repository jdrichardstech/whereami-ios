//
//  WAQuestionsViewController.swift
//  WhereAmI
//
//  Created by Devinci on 4/21/16.
//  Copyright © 2016 dankwon. All rights reserved.


import UIKit
import Alamofire

class WAQuestionsViewController: WAViewController, UICollectionViewDelegate, UICollectionViewDataSource {

	var collectionView: UICollectionView!
	var questions = Array<WAQuestion>()
	//var answerView :UIImageView!
	let icons = ["", "check.png", "ex.png"]
	
	
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = "Questions"
        self.tabBarItem.image = UIImage(named: "question.png")
		
		
	
		let notificationCenter = NSNotificationCenter.defaultCenter()
		notificationCenter.addObserver(self,
		                               selector: #selector(WAQuestionsViewController.notificationReceived(_:)),
		                               name: "ImageDownloaded",
		                               object: nil)
    }
	
	func notificationReceived(note:NSNotification){
		//print("notificationReceived")
		self.collectionView.reloadData()
	}
    

    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.whiteColor()
		
		
		
		
		let collectionViewLayout = WACollectionViewFlowLayout()
		self.collectionView = UICollectionView(frame:frame,collectionViewLayout: collectionViewLayout)
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		self.collectionView.backgroundColor = UIColor.clearColor()
		//we are populating the recycle bin before the collectionview is set up
		self.collectionView.registerClass(WACollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
		
		
		view.addSubview(self.collectionView)
		
		
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(WAQuestionsViewController.createQuestion(_:)))
        
//        let url = "http://localhost:3000/api/question"
//        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
//            if let JSON = response.result.value as? Dictionary<String, AnyObject>{
//                //
//				//print("\(JSON)")
//				
//				if let results = JSON["results"]as? Array<Dictionary<String,AnyObject>>{
//					//self.questions = results
//					
//					for i in 0..<results.count{
//						let info = results[i]
//						let question = WAQuestion()
//						question.populate(info)
//						self.questions.append(question)
//						
//						}
//					//print("\(self.questions)")
//					
//					dispatch_async(dispatch_get_main_queue(), {self.collectionView.reloadData()
//				})
//            }
//			}
//		}
}
	
    func createQuestion(btn: UIBarButtonItem){
        print("createQuestion")
        let createQuestionVc = WACreateQuestionViewController()
        self.presentViewController(createQuestionVc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	//MARK: - Delegate Function
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
		return self.questions.count
	}
	
	
	
	func configureCell(cell:WACollectionViewCell, indexPath: NSIndexPath){
		let question = self.questions[indexPath.row]
		
		cell.answerView.image = UIImage(named: icons[question.status])
		cell.answerView.alpha = (question.status == 0) ? 0: 0.6
		
		if (question.imageData != nil){
			cell.imageView.image = question.imageData
//			cell.answerView.alpha = (question.status == 0) ? 0: 0.7
//			cell.answerView.image = (question.status == 1) ? UIImage(named: "check.png") : UIImage(named: "ex.png")
			return
			
		}
		//cell.answerView.hidden = true
		
		cell.imageView.image = nil
		question.fetchImage()
		
		
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
		//let question = self.questions[indexPath.row]
		
		let cellId = "cellId"
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! WACollectionViewCell
		
		self.configureCell(cell, indexPath:indexPath)
		
			return cell
		
		
	}
	
	
	
	
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
		
		let question = self.questions[indexPath.row]
		
		mainInstance.row = indexPath.row
		print("QuestionsRow: \(mainInstance.row)")
		print("ANSWER == "+question.answer)
		let questionVc = WASingleQuestionViewController()
		questionVc.question = question
		if(question.status != 0){
			return
		}
		self.navigationController?.pushViewController(questionVc, animated: true)
	}
	
	
	
	
	
	//MARK: - My Functions
	
	override func viewWillAppear(animated: Bool){
		super.viewWillAppear(animated)
//		let url = "http://jd-where-am-i.herokuapp.com/api/question"
		let url = Constants.baseUrl + "api/question"
		Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
			if let JSON = response.result.value as? Dictionary<String, AnyObject>{
				//
				//print("\(JSON)")
				
				if let results = JSON["results"]as? Array<Dictionary<String,AnyObject>>{
					//self.questions = results
					
					for i in 0..<results.count{
						let info = results[i]
						let question = WAQuestion()
						question.populate(info)
						self.questions.append(question)
						
					}
					//print("\(self.questions)")
					
					dispatch_async(dispatch_get_main_queue(), {self.collectionView.reloadData()
					})
				}
			}
		}
		
		self.navigationController?.navigationBarHidden = false
		self.collectionView.reloadData()
	}


}


		