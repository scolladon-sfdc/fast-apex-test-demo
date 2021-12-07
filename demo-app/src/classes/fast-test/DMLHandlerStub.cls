@IsTest
public class DMLHandlerStub implements IDMLHandler {
  public MethodSpy updateStub = new MethodSpy('update');
  public void doUpdate(final SOBject sob) {
    this.updateStub.call(sob);
  }
}
