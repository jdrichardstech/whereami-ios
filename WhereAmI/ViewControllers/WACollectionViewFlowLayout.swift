//
//  WACollectionViewFlowLayout.swift
//  WhereAmI
//
//  Created by Devinci on 4/26/16.
//  Copyright © 2016 dankwon. All rights reserved.
//

import UIKit

class WACollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	required init?(coder aDecoder: NSCoder){
		super.init(coder: aDecoder)
	}
	
	override init(){
		super.init()
		
		let frame = UIScreen.mainScreen().bounds
		
		//12+10+130+10+130+10+12 = 314 this is enough for two cells can't exceed 320
		let dimension = frame.size.width/3
		
		
		self.itemSize = CGSizeMake(dimension, dimension)
		self.minimumInteritemSpacing = 0
		self.minimumLineSpacing = 0
		self.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)

	}
	
	
}
