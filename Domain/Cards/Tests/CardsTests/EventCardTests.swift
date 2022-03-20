import XCTest
import FormattedText
@testable import Cards

final class EventCardTests: XCTestCase {
	func testParsing() throws {
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
}
