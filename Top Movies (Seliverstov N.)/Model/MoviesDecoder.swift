//
//  MoviesDecoder.swift
//  Top Movies (Seliverstov N.)
//
//  Created by Nikita Seliverstov  on 07/08/2019.
//  Copyright © 2019 Nikita Seliverstov . All rights reserved.
//

import Foundation

final class MoviesDecoder {
    func decodeMovies(from data: Data) -> Movies {
        let decoder = JSONDecoder()
        return (try? decoder.decode(Movies.self, from: data)) ?? Movies(results: [])
    }
}
