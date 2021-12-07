public inherited sharing class AccountServiceWithoutDI implements IAccountService {
  public void setRating(final Account anAccount) {
    anAccount.Rating = anAccount.NumberOfEmployees > 5000
      ? 'Hot'
      : anAccount.NumberOfEmployees > 3000 ? 'Warm' : 'Cold';
    update anAccount;
  }
}
