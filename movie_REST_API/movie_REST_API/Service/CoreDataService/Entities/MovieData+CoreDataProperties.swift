// MovieData+CoreDataProperties.swift
// Copyright © Natasha Ananas. All rights reserved.

import CoreData
import Foundation

/// MovieData CoreData
public extension MovieData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: "MovieData")
    }
    @NSManaged var id: Int64
    @NSManaged var title: String?
    @NSManaged var year: String?
    @NSManaged var rate: Double
    @NSManaged var posterImageURLString: String?
    @NSManaged var descript: String?
    @NSManaged var presentImageURLString: String?
    @NSManaged var all: Bool
    @NSManaged var popular: Bool
}
