require "muzzo"
class MuzzoEventPublish < StreamPublish
  def perform
    @muzzo = Muzzo.new(link.social_account.login, link.social_account.password)

    @muzzo.add_event(link.stream.streamable.to_muzzo)
  end
end

