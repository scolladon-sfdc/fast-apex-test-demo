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

    final Mock dmlHandlerMock = Mock.forType(IDMLHandler.class);
    dmlHandlerMock.spyOn('doUpdate');

    // System under test
    IAccountService sut = new AccountServiceWithDI(
      (IDMLHandler) dmlHandlerMock.stub
    );

    // Act
    sut.setRating(subject);

    // Assert
    System.assertEquals('Hot', subject.Rating);
    Assertions.assertThat(dmlHandlerMock).method('doUpdate').hasBeenCalled();
  }

  @isTest
  static void setRating_givenAccountWithMore3000Employee_ReturnWarmRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 3001,
      Id = getRandomId(Account.getSObjectType())
    );
    final Mock dmlHandlerMock = Mock.forType(IDMLHandler.class);
    dmlHandlerMock.spyOn('doUpdate');

    // System under test
    IAccountService sut = new AccountServiceWithDI(
      (IDMLHandler) dmlHandlerMock.stub
    );

    // Act
    sut.setRating(subject);

    // Assert
    System.assertEquals('Warm', subject.Rating);
    Assertions.assertThat(dmlHandlerMock).method('doUpdate').hasBeenCalled();
  }

  @isTest
  static void setRating_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 2001,
      Id = getRandomId(Account.getSObjectType())
    );
    final Mock dmlHandlerMock = Mock.forType(IDMLHandler.class);
    dmlHandlerMock.spyOn('doUpdate');

    // System under test
    IAccountService sut = new AccountServiceWithDI(
      (IDMLHandler) dmlHandlerMock.stub
    );

    // Act
    sut.setRating(subject);

    // Assert
    System.assertEquals('Cold', subject.Rating);
    Assertions.assertThat(dmlHandlerMock).method('doUpdate').hasBeenCalled();
    //System.assert(doUpdateSpy.hasBeenCalled());
  }

  static Id getRandomId(SObjectType type) {
    final String prefix = type.getDescribe().getKeyPrefix();
    final String randomValue =
      '' + Integer.valueOf((Math.random() * 999999999));
    return Id.valueOf(prefix + randomValue.leftPad(12, '0'));
  }
}
