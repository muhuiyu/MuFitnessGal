//
//  FirebaseStorageImageDataProvider.swift
//  Roomie
//
//  Created by Mu Yu on 4/8/21.
//

//import UIKit
//import Kingfisher
//import FirebaseStorage
//
//struct FirebaseStorageImageDataProvider: ImageDataProvider {
//    let imageStoragePath: String
//    
//    var cacheKey: String {
//        return imageStoragePath
//    }
//    
//    func data(handler: @escaping (Result<Data, Error>) -> Void) {
//        Storage.storage().reference(withPath: imageStoragePath).getData(maxSize: .max) { data, error in
//            if let error = error {
//                return handler(.failure(error))
//            }
//            guard let data = data else { fatalError() }
//            handler(.success(data))
//        }
//    }
//}
