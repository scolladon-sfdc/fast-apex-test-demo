@IsTest
private class AccountServiceFastTest {
  @isTest
  static void setRating_givenAccountWithMore5000Employee_ReturnHotRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 5001,
      Id = getRandomId(Account.getSObjectType())
    );
    final DMLHandlerStub dmlHandlerStub = new DMLHandlerStub();

    // System under test
    AccountService sut = new AccountService(dmlHandlerStub);

    // Act
    sut.setRating(subject);

    // Assert
    System.assertEquals('Hot', subject.Rating);
    System.assert(dmlHandlerStub.updateStub.hasBeenCalled());
  }

  @isTest
  static void setRating_givenAccountWithMore3000Employee_ReturnWarmRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 3001,
      Id = getRandomId(Account.getSObjectType())
    );
    final DMLHandlerStub dmlHandlerStub = new DMLHandlerStub();

    // System under test
    AccountService sut = new AccountService(dmlHandlerStub);

    // Act
    sut.setRating(subject);

    // Assert
    System.assertEquals('Warm', subject.Rating);
    System.assert(dmlHandlerStub.updateStub.hasBeenCalled());
  }

  @isTest
  static void setRating_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 2001,
      Id = getRandomId(Account.getSObjectType())
    );
    final DMLHandlerStub dmlHandlerStub = new DMLHandlerStub();

    // System under test
    AccountService sut = new AccountService(dmlHandlerStub);

    // Act
    sut.setRating(subject);

    // Assert
    System.assertEquals('Cold', subject.Rating);
    System.assert(dmlHandlerStub.updateStub.hasBeenCalled());
  }

  static Id getRandomId(SObjectType type) {
    final String prefix = type.getDescribe().getKeyPrefix();
    final String randomValue =
      '' + Integer.valueOf((Math.random() * 999999999));
    return Id.valueOf(prefix + randomValue.leftPad(12, '0'));
  }
}
