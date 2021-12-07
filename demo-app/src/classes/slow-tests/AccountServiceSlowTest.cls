@IsTest
private class AccountServiceSlowTest {
  @isTest
  static void setRating_givenAccountWithMore5000Employee_ReturnHotRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 5001
    );
    insert subject;

    // System under test
    AccountService sut = new AccountService(new DMLHandler());

    // Act
    sut.setRating(subject);

    // Assert
    final Account actual = [
      SELECT Id, Rating
      FROM Account
      WHERE Id = :subject.Id
    ];
    System.assertEquals('Hot', actual.Rating);
  }

  @isTest
  static void setRating_givenAccountWithMore3000Employee_ReturnWarmRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 3001
    );
    insert subject;

    // System under test
    AccountService sut = new AccountService(new DMLHandler());

    // Act
    sut.setRating(subject);

    // Assert
    final Account actual = [
      SELECT Id, Rating
      FROM Account
      WHERE Id = :subject.Id
    ];
    System.assertEquals('Warm', actual.Rating);
  }

  @isTest
  static void setRating_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 2001
    );
    insert subject;

    // System under test
    AccountService sut = new AccountService(new DMLHandler());

    // Act
    sut.setRating(subject);

    // Assert
    final Account actual = [
      SELECT Id, Rating
      FROM Account
      WHERE Id = :subject.Id
    ];
    System.assertEquals('Cold', actual.Rating);
  }
}
