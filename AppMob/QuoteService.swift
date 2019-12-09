//
//  QuoteService.swift
//  AppMob
//
//  Created by Yoan Delvaux on 26/11/2019.
//  Copyright © 2019 Yoan Delvaux. All rights reserved.
//

import Foundation

class QuoteService {
    private init() {}
    static var shared = QuoteService()
    private let quoteUrl = URL(string: "https://api.forismatic.com/api/1.0/")!
    private let pictureUrl = URL(string: "https://source.unsplash.com/random/1000x1000")!
    private var task: URLSessionDataTask?
    
    func getQuote(callback: @escaping (Bool, Quote?) -> Void) {
        let request = createQuoteRequest()
        let session = URLSession(configuration: .default)
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode(DefQuote.self, from: data),
                        let text = (responseJSON.quoteText ?? nil),
                        let author = (responseJSON.quoteAuthor ?? nil) {
                        self.getImage { (data) in
                            if let data = data {
                                let quote = Quote(text: text, author: author, imageData: data)
                                callback(true, quote)
                            } else {
                                callback(false, nil)
                            }
                        }
                    } else {
                        callback(false, nil)
                    }
                } else {
                    callback(false, nil)
                }
            } else {
                callback(false, nil)
            }
        }
        }
        
        task?.resume()
    }

    private func createQuoteRequest() -> URLRequest {
        var request = URLRequest(url: quoteUrl)
        request.httpMethod = "POST"

        let body = "method=getQuote&lang=en&format=json"
        request.httpBody = body.data(using: .utf8)

        return request
    }
    
    private func getImage(completionHandler: @escaping ((Data?) -> Void)) {
        let session = URLSession(configuration: .default)

        task?.cancel()
        task = session.dataTask(with: pictureUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }

                completionHandler(data)
            }
        }
        task?.resume()
    }
}
