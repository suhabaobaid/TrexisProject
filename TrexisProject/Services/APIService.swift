//
//  APIService.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import UIKit

public class APIService {
    public static var defaultEnvironment = Environment.test
    
    private let session: URLSession
    
    private var headers: [String: String] = [:]
    
    
    public enum Environment: String {
        case test = "http://localhost:5555"
    }
    
    private enum HTTPMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    
    struct Constants {
        static let login = "/login"
        static let accounts = "/accounts"
        static let transactions = "/transactions"
    }
    
    enum BodyFormat {
        case urlEncodedFormat
        case params
    }
    
    public let environment: Environment
    
    init(_ environment: Environment = APIService.defaultEnvironment) {
        self.environment = environment
        
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    private func load(path: String, method: HTTPMethod = .get, query: [String: Any]? = nil, body: Any? = nil, completion: @escaping (Any?, Int, Error?) -> Void) {
        
        loadData(path: path, method: method, query: query, body: body) { (data, code, error) in
            let code = code
            
            completion(data, code, error)
        }
    }
    
    private func loadData(path: String, method: HTTPMethod = .get, query: [String: Any]? = nil, body: Any? = nil, completion: @escaping (Data?, Int, Error?) -> Void) {
        var components = URLComponents(string: environment.rawValue)
        components?.path.append(path)
        components?.queryItems = query?.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let body = body as? [String: Any] {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
            let data : Data = "username=\(body["username"] as! String)&password=\(body["password"] as! String)".data(using: .utf8)!
            request.httpBody = data
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            var jsonBody: NSString = ""
            var jsonResponse: NSString = ""
            if let body = body, let json = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted), let string = String(data: json, encoding: .utf8) {
                jsonBody = string as NSString
            }
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []), let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted), let string = String(data: jsonData, encoding: .utf8) {
                jsonResponse = string as NSString
            }
            print("----------\nRequest:\n\(method.rawValue) \(url)\n\(jsonBody)\n----------\nResponse:\n\((response as? HTTPURLResponse)?.statusCode ?? 0)\n\(jsonResponse)\n----------\n")
            
            DispatchQueue.main.async {
                completion(data, (response as? HTTPURLResponse)?.statusCode ?? 0, error)
            }
        }
        task.resume()
    }
    
    // MARK: API Calls
    
    public func login(withUsername username: String, password: String, completion: @escaping (Any?, Int, Error?) -> Void) {
        let body: [String : Any] = [
            "username": username,
            "password": password
        ]
        
        load(path: Constants.login, method: .post, body: body) { (data, code, error) in
            completion(data, code, error)
        }
    }
    
    public func getAccounts(completion: @escaping (Any?, Int, Error?) -> Void) {
        load(path: Constants.accounts, method: .get) { data, code, error in
            completion(data, code, error)
        }
    }
    
    public func fetchTransactions(for accountId: String, completion: @escaping (Any?, Int, Error?) -> Void) {
        load(path: Constants.transactions, query: ["accountId": accountId] ,completion: completion)
    }
}
