class User < ApplicationRecord
  has_many :sprint_users
  has_many :sprints, through: :sprint_users
  validates_presence_of :auth_provider, :uid
  validates_uniqueness_of :username, allow_nil: true
  validates_uniqueness_of :auth_provider, scope: :uid

  class << self
    def find_by_provider_and_uid(provider:, uid:)
      User.find_by(auth_provider: provider, uid: uid)
    end

    def create_with_omniauth(auth_hash:)
      auth = Auth.new(auth_hash)
      create! do |user|
        user.auth_provider = auth.auth_provider
        user.uid = auth.uid
        user.name = auth.name
        user.image_url = auth.image_url
        user.url = auth.url
      end
    end

    Auth = Struct.new(:auth_hash) do
      def auth_provider
        auth_hash['provider']
      end

      def uid
        auth_hash['uid']
      end

      def name
        auth_hash['info']['name']
      end

      def image_url
        auth_hash['info']['image']
      end

      def url
        auth_hash['info']['urls'][auth_provider.capitalize]
      end
    end
  end
end
