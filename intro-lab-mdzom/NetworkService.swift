//
//  NetworkService.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

class NetworkService {
    
    private let url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=b761b8f15f06447da9e129dae67bc0a2"
    
    private func getJSON(_ url: URL, completion: @escaping (Any) -> ()) {
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                completion(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getDataModel(completion: @escaping (NewsModel) -> ()) {
        guard let url = URL(string: url) else { return }
        
        getJSON(url) { json in
            let response = NewsModel(json)
            guard let unwrapResponse = response else { return }
            completion(unwrapResponse)
        }
    }
    
    func loadImage(data: String, complete: @escaping (Data) -> ()) {
        guard let url = URL(string: data) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            complete(data)
        }.resume()
    }
}
