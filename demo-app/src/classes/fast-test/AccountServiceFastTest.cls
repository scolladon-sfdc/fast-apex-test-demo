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
    Assertions.assertThat(dmlHandlerMock)
      .method('doUpdate')
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 5001,
          Id = subject.Id,
          Rating = 'Hot'
        )
      );
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
    Assertions.assertThat(dmlHandlerMock)
      .method('doUpdate')
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 3001,
          Id = subject.Id,
          Rating = 'Warm'
        )
      );
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
    Assertions.assertThat(dmlHandlerMock)
      .method('doUpdate')
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 2001,
          Id = subject.Id,
          Rating = 'Cold'
        )
      );
  }

  static Id getRandomId(SObjectType type) {
    final String prefix = type.getDescribe().getKeyPrefix();
    final String randomValue =
      '' + Integer.valueOf((Math.random() * 999999999));
    return Id.valueOf(prefix + randomValue.leftPad(12, '0'));
  }
}
