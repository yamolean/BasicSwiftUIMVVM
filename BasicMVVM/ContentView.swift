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

import SwiftUI

let url = "https://jsonplaceholder.typicode.com/photos"

struct Photo: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let thumbnailUrl: String
}

class PhotoViewModel: ObservableObject {
    @Published var photos = [Photo]()
    
    //エラーの処理後でかく
    func URLsseion() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    self.photos = try JSONDecoder().decode([Photo].self, from: data!)
                } catch {
                    print("Failed to decode JSON:", error)
                }
        }.resume()
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    //ここでforでtextにtitle,thumbnailUrlを入れまくる
                    HStack {
                        Text("title")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .background(Color.red)
                        Spacer()
                        
                    }.padding(.bottom, 4)
                    Text("thumbnailUrl")
                        .padding(.bottom, 16)
                        .background(Color.blue)
                }.padding(.horizontal, 22)
                    .padding(.top, 8)
            }
            .navigationBarTitle("タイムライン",displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
