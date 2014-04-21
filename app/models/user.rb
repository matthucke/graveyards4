class User < ActiveRecord::Base
  has_many :identities

  def self.from_omniauth(auth)
    info = auth['info']
    email = info['email'].to_s.downcase
    raise "email must not be blank" if email.blank?

    where(:email => email).first_or_initialize do |u|
      u.first_name = info['first_name'] || parse_name(info['name']).first
      u.last_name = info['last_name']|| parse_name(info['name']).last
      u.save
    end
  end


  def self.parse_name full_name
    words = full_name.to_s.split(/\s+/)
    [ words[0,words.length - 1 ].join(" "), words.last ]
  end
end
