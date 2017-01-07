class User < ApplicationRecord
  class << self
    def parse_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], auth_provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.image_url = auth_hash['info']['image']
      user.url = auth_hash['info']['urls'][user.auth_provider.capitalize]
      user.save!
      puts 'HELLELELEKNFJNDJFNJNJJNJNJNVJJV JD VJ '
      user
    end
  end
end
