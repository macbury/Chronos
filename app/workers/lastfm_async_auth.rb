class LastfmAsyncAuth < Struct.new(:social_account_id)
  
  def account
    @account ||= SocialAccount.find(social_account_id)
  end
  
  def status(stat)
    message = { :channel => "/#{account.user.api_token}/#{account.id}/auth", :data => stat.to_json }
    uri = URI.parse(RhCore::Config["faye_server"])
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def before(job)
    status({ :status => "Łączenie z Last.fm", :progress => 30 })
  end

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

  def error(job, exception)
    status({ :error => "Błąd! Nie można się połączyć z last.fm!" })
    account.destroy
  end
end
