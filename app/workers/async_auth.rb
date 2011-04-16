class AsyncAuth < Struct.new(:social_account_id)
  def account
    @account ||= SocialAccount.find(social_account_id)
  end
  
  def status(stat)
    message = { :channel => "/#{account.user.api_token}/#{account.id}/auth", :data => stat.to_json }
    uri = URI.parse(RhCore::Config["faye_server"])
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def before(job)
    status({ :status => "Łączenie z serwisem", :progress => 30 })
  end

  def error(job, exception)
    status({ :error => "Błąd! Nie można się połączyć z serwisem!" })
    account.destroy
  end
end
