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

    final Stub dmlHandlerStub = Stub.forType(IDMLHandler.class);

    // System under test
    IAccountService sut = new AccountServiceWithDI(
      (IDMLHandler) dmlHandlerStub.instance
    );

    // Act
    sut.setRating(subject);

    // Assert
    final MethodSpy doUpdateSpy = dmlHandlerStub.getMethodSpy('doUpdate');
    System.assertEquals('Hot', subject.Rating);
    System.assert(doUpdateSpy.hasBeenCalled());
  }

  @isTest
  static void setRating_givenAccountWithMore3000Employee_ReturnWarmRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 3001,
      Id = getRandomId(Account.getSObjectType())
    );
    final Stub dmlHandlerStub = Stub.forType(IDMLHandler.class);

    // System under test
    IAccountService sut = new AccountServiceWithDI(
      (IDMLHandler) dmlHandlerStub.instance
    );

    // Act
    sut.setRating(subject);

    // Assert
    final MethodSpy doUpdateSpy = dmlHandlerStub.getMethodSpy('doUpdate');
    System.assertEquals('Warm', subject.Rating);
    System.assert(doUpdateSpy.hasBeenCalled());
  }

  @isTest
  static void setRating_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 2001,
      Id = getRandomId(Account.getSObjectType())
    );
    final Stub dmlHandlerStub = Stub.forType(IDMLHandler.class);

    // System under test
    IAccountService sut = new AccountServiceWithDI(
      (IDMLHandler) dmlHandlerStub.instance
    );

    // Act
    sut.setRating(subject);

    // Assert
    final MethodSpy doUpdateSpy = dmlHandlerStub.getMethodSpy('doUpdate');
    System.assertEquals('Cold', subject.Rating);
    System.assert(doUpdateSpy.hasBeenCalled());
  }

  static Id getRandomId(SObjectType type) {
    final String prefix = type.getDescribe().getKeyPrefix();
    final String randomValue =
      '' + Integer.valueOf((Math.random() * 999999999));
    return Id.valueOf(prefix + randomValue.leftPad(12, '0'));
  }
}
