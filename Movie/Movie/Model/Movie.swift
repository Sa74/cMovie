//
//  Movie.swift
//  Movie
//
//  Created by Sasi M on 27/07/18.
//  Copyright © 2018 Sasi. All rights reserved.
//

import Foundation
import RealmSwift


// Realm Object class for Movie model
// Stores movie details from server response data
// Formats release date string (2008-04-08) into easy readable format (08 April 2008)
// Finds and sends back appropriate image width for movie poster download

class Movie: Object {
    @objc dynamic var query: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var fullOverview: String = ""
    @objc dynamic var posterPath: String = ""
    var formattedReleaseDate: String = ""
    
    
    public class func createMovie(withDetails dictionary: NSDictionary, searchQuery: String) -> Movie {
        let movie : Movie = Movie()
        movie.query = searchQuery
        movie.title = dictionary["title"] as? String ?? ""
        movie.releaseDate = dictionary["release_date"] as? String ?? ""
        movie.fullOverview = dictionary["overview"] as? String ?? ""
        movie.posterPath = dictionary["poster_path"] as? String ?? ""
        movie.formattedReleaseDate = movie.getFormattedReleaseDateString()
        return movie
    }
    
    func getFormattedReleaseDateString() -> String {
        
        if (releaseDate.count == 0) {
            return ""
        }
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.date(from: releaseDate)
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: formattedDate!)
    }
    
    func getImageSizeString(forHeight height: Float) -> String {
        var imageSizeString = ""
        if (height < 70) {
            imageSizeString = "w92"
        } else if (height < 160) {
            imageSizeString = "w185"
        } else {
            imageSizeString = "w500"
        }
        return imageSizeString
    }
}

