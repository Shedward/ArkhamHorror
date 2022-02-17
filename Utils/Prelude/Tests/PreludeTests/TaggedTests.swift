import XCTest
@testable import Prelude

final class TaggedTests: XCTestCase {
    func testCreationAndMapping() {
		enum Test1Tag {}
		enum Test2Tag {}

		typealias Test1Int = Tagged<Test1Tag, Int>
		typealias Test2Int = Tagged<Test2Tag, Int>

		let test1Int: Test1Int = 2
		let test2Int: Test2Int = 2

		let test1String = test1Int.map(String.init)
		let test2String = test2Int.map(String.init)

		// Should not compile
		// XCTAssertEqual(test1Int, test2Int)

		XCTAssertEqual(test1Int.rawValue, test2Int.rawValue)
		XCTAssertEqual(test1String.rawValue, test2String.rawValue)
    }
}
