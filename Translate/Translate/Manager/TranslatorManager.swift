//
//  TranslatorManager.swift
//  Translate
//
//  Created by 박경춘 on 2023/03/31.
//

import Alamofire
import Foundation

struct TranslatroManager {
    
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(from text: String, completionHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        
        let requestModel = Request(source: sourceLanguage.languageCode, target: targetLanguage.languageCode, text: text)
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "EsObWRV246gsskjLdc8x",
            "X-Naver-Client-Secret": "YHDQwqc113"
        ]
        
        AF.request(url, method: .post, parameters: requestModel, headers: headers)
            .responseDecodable(of: Response.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translateText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
