//
//  ViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import UIKit

class ViewController: UIViewController {

    
    private let service = MediaService()
    override func viewDidLoad() {
        super.viewDidLoad()
        service.fetchMedia(term: "Bob+Dylan") { result in
            switch result {
            case .success(let media):
                print(media)
            case .failure(_):
                print("Something went wrong!")
            }
            
            
        }
    }


}

