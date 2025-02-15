//
//  ListCellData.swift
//  PrographyAssignment
//
//  Created by 신정욱 on 2/15/25.
//

import Foundation

struct ListCellData {
    let posterPath: String
    let title: String
    let overview: String
    let voteAverage: Double
    let genreIDS: [Int]

    init(
        posterPath: String,
        title: String,
        overview: String,
        voteAverage: Double,
        genreIDS: [Int]
    ) {
        self.posterPath = "https://image.tmdb.org/t/p/original" + posterPath
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.genreIDS = genreIDS
    }
}
