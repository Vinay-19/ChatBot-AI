//
//  APICaller.swift
//  ChatBot
//
//  Created by Vinay Kumar Thapa on 2022-12-15.
//

import Foundation
import OpenAISwift

final class APICaller {
    
    static let shared = APICaller()
    
    private var client: OpenAISwift?
    
    public func setUp(){
        self.client = OpenAISwift(authToken: Constants.APIKey)
    }
    
    public func getResponse(input:String, completion: @escaping(Result<String,Error>)->Void) {
        self.client?.sendCompletion(with: input,maxTokens: 500,completionHandler: { result in
            switch result {
            case .success(let model):
                print(model)
                let response = model.choices.first?.text ?? ""
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
