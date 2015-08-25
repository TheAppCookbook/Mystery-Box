//
//  Content.swift
//  Mystery Box
//
//  Created by PATRICK PERINI on 8/24/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import Parse

class Content: PFObject, PFSubclassing {
    // MARK: Properties
    @NSManaged var title: String
    @NSManaged var type: String
    @NSManaged var url: String
    
    @NSManaged var provider_name: String
    var providerName: String! {
        get { return self.provider_name }
        set { self.provider_name = newValue }
    }
    
    @NSManaged var thumbnail_url: String
    var thumbnailURL: NSURL! {
        get { return NSURL(string: self.thumbnail_url) }
        set { self.thumbnail_url = newValue.absoluteString! }
    }
    
    @NSManaged var object_description: String
    var descriptionText: String! {
        get { return self.object_description }
        set { self.object_description = newValue }
    }
    
    static func parseClassName() -> String {
        return "Content"
    }
}