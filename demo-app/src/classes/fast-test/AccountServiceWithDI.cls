public inherited sharing class AccountServiceWithDI implements IAccountService {
  protected IDMLHandler dmlHandler;

  public AccountServiceWithDI(final IDMLHandler dmlHandler) {
    this.dmlHandler = dmlHandler;
  }

  public void setRating(final Account anAccount) {
    anAccount.Rating = anAccount.NumberOfEmployees > 5000
      ? 'Hot'
      : anAccount.NumberOfEmployees > 3000 ? 'Warm' : 'Cold';
    this.dmlHandler.doUpdate(anAccount);
  }
}
