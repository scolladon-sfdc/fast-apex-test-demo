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
    IAccountService sut = new AccountServiceWithoutDI();

    // Act
    sut.setRating(subject);

    // Assert
    final Account actual = [
      SELECT Id, Rating
      FROM Account
      WHERE Id = :subject.Id
    ];
    Assert.areEqual('Hot', actual.Rating, 'Rating should be "Hot"');
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
    IAccountService sut = new AccountServiceWithoutDI();

    // Act
    sut.setRating(subject);

    // Assert
    final Account actual = [
      SELECT Id, Rating
      FROM Account
      WHERE Id = :subject.Id
    ];
    Assert.areEqual('Warm', actual.Rating, 'Rating should be "Warm"');
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
    IAccountService sut = new AccountServiceWithoutDI();

    // Act
    sut.setRating(subject);

    // Assert
    final Account actual = [
      SELECT Id, Rating
      FROM Account
      WHERE Id = :subject.Id
    ];
    Assert.areEqual('Cold', actual.Rating, 'Rating should be "Cold"');
  }
}
