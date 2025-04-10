/// GraphQL queries for student module
class StudentQueries {
  /// Get a student by ID
  static String getStudent = r'''
    query GetStudent($id: ID!) {
      student(id: $id) {
        id
        userId
        major
        graduationYear
        enrollmentYear
        skills
        currentEnterpriseId
      }
    }
  ''';

  /// Get a student by user ID
  static String getStudentByUserId = r'''
    query GetStudentByUserId($userId: ID!) {
      studentByUserId(userId: $userId) {
        id
        userId
        major
        graduationYear
        enrollmentYear
        skills
        currentEnterpriseId
      }
    }
  ''';

  /// Get all students
  static String getAllStudents = r'''
    query GetAllStudents {
      students {
        id
        userId
        major
        graduationYear
        enrollmentYear
        skills
        currentEnterpriseId
      }
    }
  ''';

  /// Get students with pagination and filtering
  static String getStudents = r'''
    query GetStudents($input: FindStudent!, $page: Paging) {
      getStudents(input: $input, page: $page) {
        items {
          id
          userId
          major
          graduationYear
          enrollmentYear
          skills
          currentEnterpriseId
          user {
            id
          }
          currentEnterprise {
            id
          }
        }
        total
        currentPage
        totalPages
        pageSize
        hasNext
        hasPrevious
      }
    }
  ''';

  /// Create a new student
  static String createStudent = r'''
    mutation CreateStudent($input: CreateStudentInput!) {
      createStudent(input: $input) {
        id
        userId
        major
        graduationYear
        enrollmentYear
        skills
        currentEnterpriseId
      }
    }
  ''';

  /// Update an existing student
  static String updateStudent = r'''
    mutation UpdateStudent($id: ID!, $input: UpdateStudentInput!) {
      updateStudent(id: $id, input: $input) {
        id
        userId
        major
        graduationYear
        enrollmentYear
        skills
        currentEnterpriseId
      }
    }
  ''';

  /// Delete a student
  static String deleteStudent = r'''
    mutation DeleteStudent($id: ID!) {
      deleteStudent(id: $id) {
        success
      }
    }
  ''';
}
