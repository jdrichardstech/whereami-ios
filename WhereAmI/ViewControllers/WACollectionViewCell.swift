//
//  WACollectionViewCell.swift
//  WhereAmI
//
//  Created by Devinci on 4/26/16.
//  Copyright © 2016 dankwon. All rights reserved.
//

import UIKit

class WACollectionViewCell: UICollectionViewCell {
	
	var imageView:UIImageView!
	var answerView:UIImageView!
	var question: WAQuestion!
	
	required init?(coder aDecoder: NSCoder){
		super.init(coder: aDecoder)
	}
	
	override init(frame:CGRect){
		super.init(frame:frame)
		
		let width = frame.size.width
		let height = frame.size.height
		
		self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
		self.answerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
		self.answerView.alpha = 0
		self.imageView.backgroundColor = UIColor.lightGrayColor()
		self.contentView.addSubview(self.imageView)
		self.contentView.addSubview(self.answerView)
		
}
}
