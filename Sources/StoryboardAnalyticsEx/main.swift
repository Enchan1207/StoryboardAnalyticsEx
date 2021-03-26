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
print("parse...")
let parser: StoryboardXMLParser = StoryboardXMLParser(data: XMLFileData)
parser.parse { (node) in
    print(node)
    exit(EXIT_SUCCESS)
} failure: { (error) in
    print(error)
    exit(EXIT_FAILURE)
}

RunLoop.current.run()
