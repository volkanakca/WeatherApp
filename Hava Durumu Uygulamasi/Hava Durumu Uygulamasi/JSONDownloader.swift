//
//  JSONDownloader.swift
//  Hava Durumu Uygulamasi
//
//  Created by batuhankarasu on 11.12.2020.
//
//

import Foundation


class JSONDownloader {
    
    let session : URLSession
    
    
    init (config : URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init() {
        self.init(config: URLSessionConfiguration.default)
        
    }
    
    
    typealias JSON = [String : AnyObject]
    typealias JSONDownloaderCompletionHandler = (JSON? , DarkSkyError?) -> Void
    func jsonTask(with request : URLRequest , completionHandler  completion : @escaping JSONDownloaderCompletionHandler ) -> URLSessionDataTask {
        
        
        let task = session.dataTask(with: request) { data, response, error in
            
            
            guard let httpResponse  = response as? HTTPURLResponse else {
                completion(nil, DarkSkyError.RequestError)
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    } catch {
                        completion(nil,DarkSkyError.JSONParsingError)
                    }
                    
                } else {
                    //data da sorun varsa veya elde edilemediyse
                    completion(nil, DarkSkyError.invalidData)
                    
                }
                
                
                
            } else {
                //hata meydana geldi
                completion(nil, DarkSkyError.ResponseUnsuccesful(statusCode: httpResponse.statusCode))
                
            }
            
            
        }
        return task
        
    }
}
