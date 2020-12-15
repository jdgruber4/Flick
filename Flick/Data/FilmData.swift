//
//  FilmData.swift
//  Flick
//
//  Created by Gruber, John David on 11/29/20.
//

import SwiftUI
//import Foundation

//struct Post: Codable, Identifiable {
//    let id = UUID()
//    var title: String
//    var body: String
//}
//
//let headers = [
//    "x-rapidapi-key": "fb33465a55msh0bbacebd9133d72p16a29bjsn435c5b85036c",
//    "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com"
//]
//
//class Api {
//    func getPosts() {
//        //let url = URL(string: "https://unogs-unogs-v1.p.rapidapi.com/api.cgi")
//        let request = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/api.cgi")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//            }
//            let posts = try! JSONDecoder().decode([])
//    }
//}
//}




var filmData: [Film] = [
    Film(
        title: "Baby Driver",
        genre: "Crime-Thriller",
        image: "babyDriver"
    ),
    Film(
        title: "Back To The Future",
        genre: "Comedy",
        image: "backToTheFuture"
    ),
    Film(
        title: "Blackkklansman",
        genre: "Drama",
        image: "blackkklansman"
    ),
    Film(
        title: "Dunkirk",
        genre: "Action",
        image: "Dunkirk"
    ),
    Film(
        title: "Avengers: Endgame",
        genre: "Action",
        image: "Endgame"
    ),
    Film(
        title: "Iron Giant",
        genre: "Animation",
        image: "ironGiant"
    ),
    Film(
        title: "Joker",
        genre: "Drama",
        image: "Joker"
    ),
    Film(
        title: "Moonlight",
        genre: "Drama",
        image: "Moonlight"
    ),
    Film(
        title: "Pulp Fiction",
        genre: "Drama",
        image: "Pulp_fiction"
    ),
    Film(
        title: "US",
        genre: "Horror",
        image: "US"
    ),
    Film(
        title: "Fargo",
        genre: "Thriller",
        image: "Fargo"
    ),
    Film(
        title: "It's A Wonderful Life",
        genre: "Drama",
        image: "It's A Wonderful Life"
    ),
    Film(
        title: "Midsommar",
        genre: "Thriller",
        image: "Midsommar"
    ),
    Film(
        title: "Murder On The Cape",
        genre: "Legendary",
        image: "Murder On The Cape"
    ),
    Film(
        title: "Spirited Away",
        genre: "Animated",
        image: "Spirited Away"
    ),
    Film(
        title: "Uncut Gems",
        genre: "Suspense",
        image: "Uncut Gems"
    )
]
