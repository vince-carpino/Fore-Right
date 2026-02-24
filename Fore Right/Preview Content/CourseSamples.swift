import Foundation

extension Course {
    static var sampleCourses: [Course] {
        var courses: [Course] = []
        let sampleCourseNames = [
            "Oso Creek",
            "The Links",
            "St Andrews",
            "Shorecliffs",
            "Lake Forest",
        ]
        let courseLength = Bool.random() ? 18 : 9

        for courseName in sampleCourseNames {
            courses.append(
                Course(
                    name: courseName,
                    holes: (1...courseLength).map { holeNumber in
                        Hole(number: holeNumber, par: Int.random(in: 3...5))
                    }
                )
            )
        }

        return courses
    }
}
