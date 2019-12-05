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

struct Course: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let thumbnailUrl: String
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
