import Foundation

// MARK: - main constants of URL

let opt = "Opt"
let blackLotus = "Black%20Lotus"
let mainUrl = "https://api.magicthegathering.io/v1/cards?name="

// MARK: - Struct from Jason file

struct CardsInfo: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let name: String?
    let manaCost: String?
    let cmc: Double?
    let type: String?
    let cardSet, setName, text: String?
    let flavor: String?
    let artist, number: String?
    let power, toughness: String?
}

// MARK: - main function of project

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Error: \(String(describing: error))")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("response = \(response.statusCode)")

            guard let data = data else { return }
            do {
                let dataCard =  try JSONDecoder().decode(CardsInfo.self, from: data)
                print("Data printing start \n---------------------- \n")
                print("""
                  Card name: \(dataCard.cards.first?.name ?? "")
                  Mana cost: \(dataCard.cards.first?.manaCost ?? "")
                  Cmc: \(dataCard.cards.first?.cmc ?? 0)
                  Type: \(dataCard.cards.first?.type ?? "")
                  Card set: \(dataCard.cards.first?.cardSet ?? "")
                  SetName: \(dataCard.cards.first?.setName ?? "")
                  Text: \(dataCard.cards.first?.text ?? "")
                  Flavor: \(dataCard.cards.first?.flavor ?? "")
                  Artist: \(dataCard.cards.first?.artist ?? "")
                  Number: \(dataCard.cards.first?.number ?? "")
                  ---------------------
                  """)
                print("Data printing finish \n--------------------- \n")
            } catch {
                print(error)
            }
        }
    }.resume()
}

// MARK: - Function for creating URL

func doUrl (with mainUrl: String, and finalPartUrl: String) -> String {
    let url = "\(mainUrl)\(<<>>(finalPartUrl))"
    return url
}

// MARK: - Extension for make custom quotes function

prefix operator <<>>
extension String {
    static prefix func <<>> (_ urlPath: String) -> String {
        return("%22\(urlPath)%22")
    }
}

// MARK: - Main Action

getData(urlRequest: doUrl(with: mainUrl, and: opt))
getData(urlRequest: doUrl(with: mainUrl, and: blackLotus))
