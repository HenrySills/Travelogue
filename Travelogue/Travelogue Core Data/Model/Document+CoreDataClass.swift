//
//  Document+CoreDataClass.swift
//  Travelogue Core Data
//
//  Created by Dale Musser on 7/9/18.
//  Copyright © 2018 Dale Musser. All rights reserved.
//
//

import UIKit
import CoreData
import Foundation

@objc(Document)
public class Document: NSManagedObject {
    var modifiedDate: Date? {
        get {
            return rawModifiedDate as Date?
        }
        set {
            rawModifiedDate = newValue as NSDate?
        }
    }
    
    var image: UIImage? {
        get {
            if let imageData = rawImage as Data? {
                return UIImage(data: imageData)
            }
            return nil
        } set {
            let imageData = newValue!.pngData() as NSData?
            rawImage = imageData
        }
    }
    convenience init?(name: String?, content: String?, image: UIImage) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let name = name, name != "" else {
                return nil
        }
        self.init(entity: Document.entity(), insertInto: managedContext)
        self.name = name
        self.content = content
        self.image = image
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
        
        self.modifiedDate = Date(timeIntervalSinceNow: 0)
    }
    
    func update(name: String, content: String?, image: UIImage?) {
        self.name = name
        self.content = content
        self.image = image
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
    
        self.modifiedDate = Date(timeIntervalSinceNow: 0)
    }
}
