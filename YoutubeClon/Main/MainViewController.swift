//
//  MainViewController.swift
//  YoutubeClon
//
//  Created by Marielsy on 11/03/22.
//

import UIKit


class MainViewController: UIViewController {
    var rootPageViewController : RootPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController{
            destination.delegateRoot = self
            rootPageViewController = destination
            
            
        }
    }
}
extension MainViewController : RootPageProtocol{
    func currentPage(_ index: Int) {
        print("currentPage: ", index)
    }
    
    
    
    
}
