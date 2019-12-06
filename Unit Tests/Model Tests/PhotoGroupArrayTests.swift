//
//  PhotoGroupArrayTests.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/6/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import XCTest
@testable import Mars_Explorer

class PhotoGroupArrayTests: XCTestCase {
	func testInitArrayWithOneGroup() {
		let array: [PhotoGroup] = .init(photos: [
			Photo(
				id: 1,
				sol: 1,
				imgSrc: "",
				earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
				camera: Camera(
					name: "",
					fullName: ""),
				rover: Rover(
					id: 1,
					name: "rover name",
					landingDate: Date(),
					launchDate: Date(),
					status: .active,
					maxSol: 0,
					maxDate: Date(),
					totalPhotos: 0,
					cameras: []))
		])
		XCTAssert(array.count == 1, "[PhotoGroup] was not initialized correctly. Should contain 1 value but contains \(array.count) values instead.")
	}
	
	func testInitArrayWithTwoPhotosOneGroup() {
		let array: [PhotoGroup] = .init(photos: [
			Photo(
				id: 1,
				sol: 1,
				imgSrc: "",
				earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
				camera: Camera(
					name: "",
					fullName: ""),
				rover: Rover(
					id: 1,
					name: "rover name",
					landingDate: Date(),
					launchDate: Date(),
					status: .active,
					maxSol: 0,
					maxDate: Date(),
					totalPhotos: 0,
					cameras: [])),
			Photo(
				id: 2,
				sol: 1,
				imgSrc: "",
				earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
				camera: Camera(
					name: "",
					fullName: ""),
				rover: Rover(
					id: 1,
					name: "rover name",
					landingDate: Date(),
					launchDate: Date(),
					status: .active,
					maxSol: 0,
					maxDate: Date(),
					totalPhotos: 0,
					cameras: []))
		])
		XCTAssert(array.count == 1, "[PhotoGroup] was not initialized correctly. Should contain 2 value but contains \(array.count) values instead.")
	}
	
	func testInitArrayWithTwoPhotosTwoGroups() {
		let array: [PhotoGroup] = .init(photos: [
			Photo(
				id: 1,
				sol: 1,
				imgSrc: "",
				earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
				camera: Camera(
					name: "",
					fullName: ""),
				rover: Rover(
					id: 1,
					name: "rover name",
					landingDate: Date(),
					launchDate: Date(),
					status: .active,
					maxSol: 0,
					maxDate: Date(),
					totalPhotos: 0,
					cameras: [])),
			Photo(
				id: 2,
				sol: 1,
				imgSrc: "",
				earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 4))!,
				camera: Camera(
					name: "",
					fullName: ""),
				rover: Rover(
					id: 1,
					name: "rover name",
					landingDate: Date(),
					launchDate: Date(),
					status: .active,
					maxSol: 0,
					maxDate: Date(),
					totalPhotos: 0,
					cameras: []))
		])
		XCTAssert(array.count == 2, "[PhotoGroup] was not initialized correctly. Should contain 2 value but contains \(array.count) values instead.")
	}
	
	func testAppendArrayWithZeroExtraGroup() {
		var array = [
			PhotoGroup(
				date: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
				photos: [
					Photo(
					id: 1,
					sol: 1,
					imgSrc: "",
					earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
					camera: Camera(
						name: "",
						fullName: ""),
					rover: Rover(
						id: 1,
						name: "rover name",
						landingDate: Date(),
						launchDate: Date(),
						status: .active,
						maxSol: 0,
						maxDate: Date(),
						totalPhotos: 0,
						cameras: []))
			])
		]
		let insert = array.append(photos: [
			Photo(
			id: 2,
			sol: 1,
			imgSrc: "",
			earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
			camera: Camera(
				name: "",
				fullName: ""),
			rover: Rover(
				id: 1,
				name: "rover name",
				landingDate: Date(),
				launchDate: Date(),
				status: .active,
				maxSol: 0,
				maxDate: Date(),
				totalPhotos: 0,
				cameras: []))
		])
		XCTAssert(array.count == 1, "[PhotoGroup] was not appended correctly. Should contain 1 value but contains \(array.count) values instead.")
		XCTAssert(insert.rowsInserted == [IndexPath(row: 1, section: 0)], "[PhotoGroup] did not return the correct value for rows inserted. Should contain [(row: 1, section: 0)] but contains \(insert.rowsInserted) instead.")
		XCTAssert(insert.sectionsInserted == [], "[PhotoGroup] did not return the correct value for sections inserted. Should contain [] but contains \(insert.sectionsInserted) instead.")
	}
	
	func testAppendArrayWithOneExtraGroup() {
		var array = [
			PhotoGroup(
				date: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
				photos: [
					Photo(
					id: 1,
					sol: 1,
					imgSrc: "",
					earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 3))!,
					camera: Camera(
						name: "",
						fullName: ""),
					rover: Rover(
						id: 1,
						name: "rover name",
						landingDate: Date(),
						launchDate: Date(),
						status: .active,
						maxSol: 0,
						maxDate: Date(),
						totalPhotos: 0,
						cameras: []))
			])
		]
		let insert = array.append(photos: [
			Photo(
			id: 2,
			sol: 1,
			imgSrc: "",
			earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 12, day: 4))!,
			camera: Camera(
				name: "",
				fullName: ""),
			rover: Rover(
				id: 1,
				name: "rover name",
				landingDate: Date(),
				launchDate: Date(),
				status: .active,
				maxSol: 0,
				maxDate: Date(),
				totalPhotos: 0,
				cameras: []))
		])
		XCTAssert(array.count == 2, "[PhotoGroup] was not appended correctly. Should contain 2 value but contains \(array.count) values instead.")
		XCTAssert(insert.rowsInserted == [], "[PhotoGroup] did not return the correct value for rows inserted. Should contain [] but contains \(insert.rowsInserted) instead.")
		XCTAssert(insert.sectionsInserted == [1], "[PhotoGroup] did not return the correct value for sections inserted. Should contain [1] but contains \(insert.sectionsInserted) instead.")
	}
}
