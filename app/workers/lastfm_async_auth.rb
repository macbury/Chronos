class LastfmAsyncAuth < AsyncAuth

  def perform
    @lastfm = LastFm.new(account.login, account.password)
    
    if @lastfm.logged_in?
      status({ :status => "Zalogowano, sprawdzanie czy konto jest przypisane do zespołu...", :progress => 70 })
      band_name = @lastfm.get_band_name
      
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
