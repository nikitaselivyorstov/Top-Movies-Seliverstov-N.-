//
//  Top_Movies__Seliverstov_N__Tests.swift
//  Top Movies (Seliverstov N.)Tests
//
//  Created by Nikita Seliverstov  on 05/08/2019.
//  Copyright © 2019 Nikita Seliverstov . All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import Top_Movies__Seliverstov_N__



// Protocol for MOCK/Real

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

//MARK: Test

class Top_Movies__Seliverstov_N__Tests: XCTestCase {
    
    
    
    var httpClient: HttpClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_get_request_with_URL() {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=6bbbe01661ad34bc4dbf6a5d5b984d8d&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2019&vote_average.gte=8") else {
            print("URL is missing")
            return
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=6bbbe01661ad34bc4dbf6a5d5b984d8d&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2019&vote_average.gte=8") else {
            print("URL is missing")
            return
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        httpClient.get(url: URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=6bbbe01661ad34bc4dbf6a5d5b984d8d&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_year=2019&vote_average.gte=8")!) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }
}

//MARK: HttpClient Implementation

class HttpClient {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
        
    }
    func get( url: URL, callback: @escaping completeClosure ){
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}

//MARK: Conform the protocol


//MARK: MOCK

class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
    
}



class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    
    
    func resume() {
        resumeWasCalled = true
    }
}

//MARK: Conform the protocol

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}


extension URLSessionDataTask: URLSessionDataTaskProtocol {}
