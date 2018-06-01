//
//  NetworkRequestBuilder.swift
//  Scout
//
//

import Foundation
import Alamofire

class NetworkRequestBuilder: NetworkRequestBuilderProtocol {

    let baseURL: URL
    var userAuthorizationHeader: String?
    
    var manager: SessionManager!

    fileprivate let mapper: NetworkMappingProtocol
    fileprivate var baseURLString: String { return baseURL.absoluteString }
    fileprivate let headerTokenKey = "x-access-token"
    fileprivate let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImMyNzY3MGRlLThjODItNDBjZS05NWYzLWUwMzgzZmI4OGY5MSIsImlhdCI6MTUyNjM5NzIzNn0.QZa12Nq2hTEAJaqZMraWcGHUtVaN09m-Wk7S-KVohBI"
    
    // MARK: Init
    init(withBaseURL baseURL: URL, mapper: NetworkMappingProtocol) {
        
        self.baseURL = baseURL
        self.mapper = mapper
    }
    
    // MARK: Auth
    func buildPostRegistrationRequest(withUserName userName: String, email: String, password: String) -> URLRequest? {
        
        let parameters = [
                             "name" : userName,
                             "email" : email,
                             "password" : password
                         ]
        
        let URLString = String(format: "%@api/auth/register", self.baseURLString)
        
        return manager.request(URLString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).request
    }
    
    func buildPostScoutTitlesRequest(withCmd cmd: String, userid: String) -> URLRequest? {
        
        let parameters = [
            "cmd" : cmd,
            "userid" : userid
        ]
        
        let headres = [headerTokenKey : token]
        let URLString = String(format: "%@command/intent", self.baseURLString)
        
        return manager.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding(), headers: headres).request
    }
    
    func buildPostScoutVoiceInputRequest(withCmd cmd: String, userid: String, searchTerms: String) -> URLRequest? {
        
        let parameters = [
            "cmd" : cmd,
            "userid" : userid,
            "searchTerms" : searchTerms
        ]
        
        let headres = [headerTokenKey : token]
        let URLString = String(format: "%@command/intent", self.baseURLString)
        
        return manager.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding(), headers: headres).request
    }
    
    func buildPostScoutSkimVoiceInputRequest(withCmd cmd: String, userid: String, searchTerms: String) -> URLRequest? {
        
        let parameters = [
            "cmd" : cmd,
            "userid" : userid,
            "searchTerms" : searchTerms
        ]
        
        let headres = [headerTokenKey : token]
        let URLString = String(format: "%@command/intent", self.baseURLString)
        
        return manager.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding(), headers: headres).request
    }
    
    func buildPostArticleRequest(userid: String, url: String) -> URLRequest? {
        
        let parameters = [
            "userid" : userid,
            "url" : url
        ]
        
        let headres = [headerTokenKey : token]
        let URLString = String(format: "%@command/article", self.baseURLString)
        
        return manager.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding(), headers: headres).request
    }
    
    func buildPostSummaryRequest(userid: String, url: String) -> URLRequest? {
        
        let parameters = [
            "userid" : userid,
            "url" : url
        ]
        
        let headres = [headerTokenKey : token]
        let URLString = String(format: "%@command/summary", self.baseURLString)
        
        return manager.request(URLString, method: .post, parameters: parameters, encoding: URLEncoding(), headers: headres).request
    }
}

