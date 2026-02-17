import Foundation

extension Course {
    static var sampleCourses: [Course] = {
        var courses: [Course] = []
        let sampleCourseNames = [
            "Oso Creek",
            "The Links",
            "St Andrews",
        ]

        for courseName in sampleCourseNames {
            courses.append(
                Course(
                    name: courseName,
                    holes: (1...18).map { holeNumber in
                        Hole(number: holeNumber, par: Int.random(in: 3...5))
                    }
                )
            )
        }

        return courses
    }()
}
