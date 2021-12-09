@IsTest
@NamespaceAccessible
public class ParameterizedMethodSpyCall {
  private List<Object> params;
  public Object value;

  @NamespaceAccessible
  public ParameterizedMethodSpyCall(List<Object> params) {
    this.params = params;
  }

  @NamespaceAccessible
  public void thenReturn(Object value) {
    this.value = value;
  }

  @NamespaceAccessible
  public boolean matches(List<Object> params) {
    if (this.params.size() != params.size()) {
      return false;
    }
    if (this.params.equals(params)) {
      return true;
    }
    for (Integer i = 0; i < params.size(); i++) {
      Object expectedParam = this.params.get(i);
      Object actualParam = params.get(i);
      if (actualParam != expectedParam) {
        return false;
      }
    }
    return true;
  }
}
