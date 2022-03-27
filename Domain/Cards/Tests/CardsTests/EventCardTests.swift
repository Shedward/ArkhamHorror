import XCTest
import FormattedText
@testable import Cards

final class EventCardTests: XCTestCase {
	func testSingleParsing() throws {
		let testData = try TestData()
		let hibbsRoadhouse1 = try testData.eventCardData(named: "easttown1.hibbs_roadhouse.yml")
		let card = try EventCard(
			data: hibbsRoadhouse1,
			scriptParser: try EventActionScriptParser.create(),
			formattedTextParser: FormattedTextParser()
		)

		XCTAssertEqual(card.id, "easttown1.hibbs_roadhouse")
		XCTAssertEqual(card.regionId, "hibbs_roadhouse")
	}

    func testAllCards() throws {
        let testData = try TestData()
        let scriptParser = try EventActionScriptParser.create()
        let formattedTextParser = FormattedTextParser()

        try testData.forEachEventCard { url, data in
            do {
                let card = try EventCard(
                    data: try data.get(),
                    scriptParser: scriptParser,
                    formattedTextParser: formattedTextParser
                )
                XCTAssertEqual(url.lastPathComponent, "\(card.id.rawValue).yml")
            } catch {
                XCTFail(
                    """
                    Failed to load card \(url):
                    \(error.localizedDescription)
                    """
                )
            }
        }
    }
}
