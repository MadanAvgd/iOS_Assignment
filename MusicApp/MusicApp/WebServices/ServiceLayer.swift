//
//  ServiceLayer.swift
//  MusicApp
//
//  Created by Madan on 08/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import Foundation
class ServiceLayer {
    
    let defaulatSession = URLSession(configuration: .default)
    var dataTask:URLSessionDataTask? = nil
    
    func servcieRequest(urlString: String, withCompletion completion: @escaping (Tune?, String?) -> Void)
    {
        cancelReuest()
        guard let url = URL(string: urlString) else {
            return
        }
        //print(url)
        let request = RequestFactory.listMusicRequest(method: .GET, url: url)
        
        dataTask = defaulatSession.dataTask(with:request, completionHandler: { (data: Data?, response: URLResponse?,
            error: Error?) -> Void in
            
            if let error = error{
                completion(nil, error.localizedDescription)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do{
                let tune = try JSONDecoder().decode(Tune.self, from: data)
                completion(tune,nil)
            }
            catch let err{
                print(err.localizedDescription)
                return
            }
        })
        dataTask?.resume()
    }
    
    func cancelReuest()  {
        if let dataTask = dataTask{
            dataTask.cancel()
        }
        dataTask = nil
    }
    
}
