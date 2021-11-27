import Foundation
import RealmSwift

// Table
class Record: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var title: String
    @Persisted var writter: String
    @Persisted var descript: String
    @Persisted var link: String
    @Persisted var category: String
    
    // Blog : postdate
    // Book : price, image, pubdate
    @Persisted var pubdate: String?
    
    @Persisted var image: String?
    @Persisted var price: String?
    
    convenience init(title: String, writter: String, descript: String, link: String, category: String, pubdate: String?, image: String?, price: String?) {
        self.init()
        
        self.title = title
        self.writter = writter
        self.descript = descript
        self.link = link
        self.category = category
        
        self.pubdate = pubdate
        self.image = image
        self.price = price
        }
}


