//
// Storyboardって具体的になにが書いてあるの?
//
import Foundation

// Resources/ からXMLファイルを読み込む
print("load Storyboard.xml...")
let XMLFileName = "sample"
guard let XMLFileURL = Bundle.module.url(forResource: XMLFileName, withExtension: "xml"),
      let XMLFileData = try? Data(contentsOf: XMLFileURL) else {exit(EXIT_FAILURE)}

// XMLパーサに通す
let semaphore = DispatchSemaphore(value: 0)
print("parse...")
let parser: XMLDOMParser = XMLDOMParser(data: XMLFileData)
parser.parse { (node) in
    print(node)
    semaphore.signal()
} failure: { (error) in
    print(error)
    semaphore.signal()
}
semaphore.wait()

// webサイトから持ってきてパース
//let task = URLSession.shared.dataTask(with: URL(string: "https://example.com")!) { (data, response, error) in
//    print(response)
//    semaphore.signal()
//}
//task.resume()
//semaphore.wait()

exit(EXIT_SUCCESS)
