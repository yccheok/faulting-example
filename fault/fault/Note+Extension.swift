//
//  NSPassword+Extension.swift
//  wenote-ios
//
//  Created by Yan Cheng Cheok on 22/10/2021.
//

import Foundation
import CoreData

extension Note {
    static let uuid: UUID = UUID(uuidString: "F80CE382-0345-49A0-AD34-2BAF317AB0C0")!
    
    convenience init(context: NSManagedObjectContext, lite_title: String, heavy_body: String) {
        self.init(context: context)
        
        self.lite_title = lite_title
        self.heavy_body = heavy_body
        self.uuid = Note.uuid
    }
}
