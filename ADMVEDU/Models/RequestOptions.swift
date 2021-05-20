import Foundation

struct RequestOptions {
<<<<<<< HEAD
    var term = ""
    var country = "US"
    var media: MediaType = .all
    var entity = ""
    var attribute = ""
    var limit = 50
    var lang = "en_us"
    var explisit: Explisitness = .yes
=======
	var term = ""
	var country: Country = .us
	var media: MediaType = .all
	var entity = ""
	var attribute = ""
	var limit = 50
	var lang = "en_us"
	var explisit: Explisitness = .yes
>>>>>>> b10d50e50ad2b6b6b9bf17a930538c97d33ca575
}
