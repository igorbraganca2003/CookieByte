import Foundation
import UIKit

struct CookiesModel: Decodable {
    let cookieName: String
    let price: Float
    var color: String
    let pic: String
    let description: String
    var isFavorite: Bool
    
    // Função para converter o código da cor para UIColor
    var uiColor: UIColor {
        return UIColor(named: color) ?? UIColor.white
    }
}


class Cookies {
    static var cookieShared = Cookies()

    var cookie: [CookiesModel] = []

    init() {
        loadCookies()
    }

    func loadCookies() {
        let urlString = "https://raw.githubusercontent.com/igorbraganca2003/CookieByte/dev/cookies.json"
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erro na requisição: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Dados não disponíveis")
                return
            }

            do {
                let decoder = JSONDecoder()
                let cookies = try decoder.decode([CookiesModel].self, from: data)
                DispatchQueue.main.async {
                    self.cookie = cookies
                    // Converter cores de string para UIColor
                    self.cookie = self.cookie.map { cookie in
                        var mutableCookie = cookie
                        //mutableCookie.color = cookie.uiColor
//                        print(mutableCookie)
                        return mutableCookie
                        
                    }
                    print("Cookies carregados: \(self.cookie)")
                    //completion()
                }
            } catch {
                print("Erro ao fazer parse do JSON: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}
