public inherited sharing class AccountService {
  protected IDMLHandler dmlHandler;

  public AccountService(final IDMLHandler dmlHandler) {
    this.dmlHandler = dmlHandler;
  }

  public void setRating(final Account anAccount) {
    anAccount.Rating = anAccount.NumberOfEmployees > 5000
      ? 'Hot'
      : anAccount.NumberOfEmployees > 3000 ? 'Warm' : 'Cold';
    this.dmlHandler.doUpdate(anAccount);
  }
}
