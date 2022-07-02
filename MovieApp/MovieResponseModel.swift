//
//  MovieResponseModel.swift
//  MovieApp
//
//  Created by Sohanur Rahman on 2/7/22.
//

import Foundation

struct MovieResponseModel: Codable {
    let page: Int?
    let results: [MovieDataResponseModel]?
    let total_pages: Int?
    let total_results: Int?
}

struct MovieDataResponseModel: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title,
        overview: String
    let popularity: Double
    let poster_path: String?
    let release_date,
        title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
