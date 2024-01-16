//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Easin Md. Hosen on 16/1/24.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {

    private var url: URL?
    
    init(url: URL?){
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemGreen
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
