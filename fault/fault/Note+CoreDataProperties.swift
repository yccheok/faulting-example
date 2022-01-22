//
//  Note+CoreDataProperties.swift
//  fault
//
//  Created by Yan Cheng Cheok on 22/01/2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var heavy_body: String?
    @NSManaged public var lite_title: String?
    @NSManaged public var uuid: UUID?

}

extension Note : Identifiable {

}
