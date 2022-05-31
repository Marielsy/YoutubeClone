import Foundation

struct PlaylistItemsModel: Decodable{
    let kind: String
    let etag: String
    let items: [Item]
    let pageInfo : PageInfo
    
    struct Item : Decodable{
        let kind : String
        let etag : String
        let id : String
        let snippet : VideoModel.Item.Snippet
    }
    
    struct PageInfo: Decodable{
        let totalResults: Int
        let resultsPerPage: Int
    }
}
