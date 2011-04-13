require "muzzo"
class MuzzoAsyncAuth < AsyncAuth

  def perform
    @muzzo = Muzzo.new(account.login, account.password)
    
    if @muzzo.logged_in?
      status({ :status => "Zalogowano, sprawdzanie czy konto jest przypisane do zespołu...", :progress => 70 })
      band_name = @muzzo.get_band_name
      
      if band_name
        account.name = band_name
        account.save
        status({ :success => "Konto zostało dodane! Zaraz nastąpi przekierowanie...", :progress => 100 })
      else
        status({ :error => "Brak przypisanego zespołu!" })
        account.destroy
      end
    else
      status({ :error => "Nieprawidłowy login lub hasło!" })
      account.destroy
    end
  end

end
