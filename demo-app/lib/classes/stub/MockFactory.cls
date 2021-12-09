@isTest
public class MockFactory {
  public static Object stub(final Type aType, final MockDriver aDriver) {
    return Test.createStub(aType, aDriver);
  }
}
