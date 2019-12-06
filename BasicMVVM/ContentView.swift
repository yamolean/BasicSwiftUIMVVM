//
//  ContentView.swift
//  BasicMVVM
//
//  Created by 矢守叡 on 2019/12/06.
//  Copyright © 2019 yamolean. All rights reserved.
//

//https://jsonplaceholder.typicode.com/photos
//[
//{
//  "albumId": 1,
//  "id": 1,
//  "title": "accusamus beatae ad facilis cum similique qui sunt",
//  "url": "https://via.placeholder.com/600/92c952",
//  "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//},...]
//

import SwiftUI

let photoApiUrl = "https://jsonplaceholder.typicode.com/photos"

struct Photo: Identifiable, Codable {
    let id = UUID()
    var title: String
    var thumbnailUrl: String
    
    enum Codingkeys: String, CodingKey {
        case title = "title"
        case thumbnailUrl = "thumbnailUrl"
    }
}

class PhotoViewModel: ObservableObject {
    @Published var photos: [Photo] = [
        .init(title: "title",thumbnailUrl: "URL")
    ]
    
    func fetchPhotos() {
        guard let url = URL(string: photoApiUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                print(data)
                do {
                    self.photos = try JSONDecoder().decode([Photo].self, from: data)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct ContentView: View {
    @ObservedObject var photoViewModel = PhotoViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(photoViewModel.photos) { photo in
                        HStack {
                            Text(photo.title)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                            Spacer()
                        }.padding(.bottom, 4)
                        HStack {
                            Text(photo.thumbnailUrl)
                                .padding(.bottom, 16)
                            Spacer()
                        }
                    }
                }.padding(.horizontal, 22)
                    .padding(.top, 8)
            }
            .navigationBarTitle("PhotoGalellry",displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.photoViewModel.fetchPhotos()
            }, label: {
                Text("Session")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
