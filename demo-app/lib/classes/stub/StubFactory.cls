@isTest
public class StubFactory {
  static private Map<Object, Mock> stubMap = new Map<Object, Mock>();
  public static Object stub(final Type aType) {
    final Mock mock = new Mock();
    Object stub = Test.createStub(aType, mock);
    stubMap.put(stub, mock);

    return stub;
  }

  static public Mock getMock(final Object aStub) {
    return stubMap.get(aStub);
  }
}
