public with sharing class Stub {
  public Object instance { get; private set; }
  private Mock mock;

  private Stub(final Type aType) {
    this.mock = new Mock();
    this.instance = Test.createStub(aType, this.mock);
  }

  public MethodSpy getMethodSpy(final String methodName) {
    return this.mock.getSpy(methodName);
  }

  public static Stub forType(final Type aType) {
    return new Stub(aType);
  }
}
