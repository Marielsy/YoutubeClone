//
//  HomeViewController.swift
//  YoutubeClon
//
//  Created by Marielsy on 11/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableViewHome: UITableView!
    lazy var presenter = HomePresenter(delegate: self)
    private  var objectList : [[Any]] = []
    private var sectionTitleList: [String] = []


   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
      
        Task{
            await presenter.getHomeObjects()  
        }

    }
    func configTableView(){
        let nibChannel = UINib(nibName: "\(Channelcell.self)", bundle: nil)
        tableViewHome.register(nibChannel, forCellReuseIdentifier: "\(Channelcell.self)")

        let nibVideo = UINib(nibName: "\(VideoCell.self)", bundle: nil)
        tableViewHome.register(nibVideo, forCellReuseIdentifier: "\(VideoCell.self)")

        
        let nibPlaylist = UINib(nibName: "\(PlaylistCell.self)", bundle: nil)
        tableViewHome.register(nibPlaylist, forCellReuseIdentifier: "\(PlaylistCell.self)")

            
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
    }
}

extension HomeViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = objectList[indexPath.section]
        if let channel = item as? [ChannelModel.Items]{
            guard let channelCell = tableView.dequeueReusableCell(withIdentifier: "\(Channelcell.self)", for: indexPath) as? Channelcell else{
                return UITableViewCell()
            }
            return channelCell
            
        }else if let playlistItems = item as? [PlaylistItemsModel.Item]{
            guard let playlistItemsCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else{
                return UITableViewCell()
            }
            return playlistItemsCell
        
    }else if let videos = item as? [VideoModel.Item]{
        guard let videoCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else{
            return UITableViewCell()
        }
        return videoCell
     }else if let playlist = item as? [PlaylistModel.Items]{
        guard let PlaylistCell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistModel.self)", for: indexPath) as? PlaylistCell else{
            return UITableViewCell()
        }
        return PlaylistCell
    }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section]
    }

}
extension HomeViewController : HomeViewProtocol{
    func getData(list: [[Any]], sectionTitleList: [String]) {
        objectList = list
        self.sectionTitleList = sectionTitleList
        tableViewHome.reloadData()
        }
    }

