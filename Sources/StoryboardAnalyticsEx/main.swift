import Foundation

let url = URL(string: "https://api.github.com/users/Enchan1207")!
let request = URLRequest(url: url)
URLSession.shared.dataTask(with: request) { data, _, error in
  if let data = data {
    let responseText = String(data: data, encoding: .utf8)!
    print(responseText)
    exit(EXIT_SUCCESS)
  } else {
    print(error!.localizedDescription)
    exit(EXIT_FAILURE)
  }
}.resume()

RunLoop.current.run() // or dispatchMain()
