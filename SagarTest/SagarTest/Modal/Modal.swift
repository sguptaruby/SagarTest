
import Foundation

struct Modal: CreatableFromJSON { // TODO: Rename this struct
    let response: String
    let search: [Search]
    let totalResults: String
    init(response: String, search: [Search], totalResults: String) {
        self.response = response
        self.search = search
        self.totalResults = totalResults
    }
    init?(json: [String: Any]) {
        guard let response = json["Response"] as? String else { return nil }
        guard let search = Search.createRequiredInstances(from: json, arrayKey: "Search") else { return nil }
        guard let totalResults = json["totalResults"] as? String else { return nil }
        self.init(response: response, search: search, totalResults: totalResults)
    }
    struct Search: CreatableFromJSON { // TODO: Rename this struct
        let imdbID: String
        let poster: URL
        let title: String
        let type: String
        let year: String
        init(imdbID: String, poster: URL, title: String, type: String, year: String) {
            self.imdbID = imdbID
            self.poster = poster
            self.title = title
            self.type = type
            self.year = year
        }
        init?(json: [String: Any]) {
            guard let imdbID = json["imdbID"] as? String else { return nil }
            guard let poster = URL(json: json, key: "Poster") else { return nil }
            guard let title = json["Title"] as? String else { return nil }
            guard let type = json["Type"] as? String else { return nil }
            guard let year = json["Year"] as? String else { return nil }
            self.init(imdbID: imdbID, poster: poster, title: title, type: type, year: year)
        }
    }
}
