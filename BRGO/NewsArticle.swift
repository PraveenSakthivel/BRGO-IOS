//
//  NewsArticle.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/6/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import Foundation

/** Most of the data used comes as two connected strings. This class allows us to keep
 them connected */
class newsarticle {
    var title: String = String();
    var description: String = String();
    init(name: String, desc: String)
    {
    title = name
    description = desc
    }
    init(){
        
    }
}
