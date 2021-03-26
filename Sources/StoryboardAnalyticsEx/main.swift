//
// Storyboardって具体的になにが書いてあるの?
//
import Foundation

// Resources/ からXMLファイルを読み込む
let XMLFileName = "Storyboard"
print("load \(XMLFileName).xml...")
guard let XMLFileURL = Bundle.module.url(forResource: XMLFileName, withExtension: "xml"),
      let XMLFileData = try? Data(contentsOf: XMLFileURL) else {exit(EXIT_FAILURE)}

// XMLパーサに通す
print("parse...")
let semaphore = DispatchSemaphore(value: 0)
var root: Element?
let parser: XMLDOMParser = XMLDOMParser(data: XMLFileData)
parser.parse { (node) in
    root = node as? Element
    semaphore.signal()
} failure: { (error) in
    print(error)
    semaphore.signal()
}
semaphore.wait()
guard let root = root else{exit(EXIT_FAILURE)}

// SBに含まれるConrtollerを抽出
guard let scenes = root.getElementsBy(tagName: "scenes").first?.getElementsBy(tagName: "scene") else {exit(EXIT_FAILURE)}
for scene in scenes{
    print("-------------------------")
    
    print("scene (id: \(scene.attributes["sceneID"]!))")
    let objects = scene.getElementsBy(tagName: "objects").first!.getElements(by: "sceneMemberID", value: "viewController")
    for object in objects{
        print("  \(object.tagName) (id: \(object.attributes["id"]!))")
        
        // segue取得
        guard let segues = object.getElementsBy(tagName: "connections").first?.getElementsBy(tagName: "segue") else {continue}
        print("  segue:")
        for segue in segues {
            print("    kind: \(segue.attributes["kind"] ?? "none") destination: \(segue.attributes["destination"] ?? "none") (id: \(object.attributes["id"]!)) ")
        }
    }
}

exit(EXIT_SUCCESS)
