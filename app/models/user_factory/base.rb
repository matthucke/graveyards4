module UserFactory
  class Base
    attr_accessor :auth, :user_info, :identity, :user

    def initialize(auth, identity=nil)
      @auth=auth
      @user_info = auth['info'] || {}
      @identity=identity
    end

    def provider
      @auth.provider.to_sym
    end

    def email
      e=user_info['email']
      return e unless e.blank?

      # Provide a fake one.
      "user#{@auth.uid}@#{@auth.provider}.example.com"
    end

    def find_or_create_user
      if email.blank?
        create_user_without_email
      else
        find_or_create_user_from_email
      end
    end

    def find_or_create_user_from_email
      @user = User.where(:email => email).first_or_initialize do |u|
        finish_creating(u)
      end
    end

    def create_user_without_email
      @user = User.new.tap do |u|
        finish_creating(u)
      end
    end


    def finish_creating(user)
      # set name
      user.full_name = extract_full_name
      user.save!
      user
    end

    def extract_full_name
      n = user_info['name']
      return n unless n.blank?

      n = user_info['full_name']
      return n unless n.blank?

      words = [info['first_name'], info['last_name']].compact
      unless words.empty?
        return words.join(' ')
      end

      unless email.blank?
        return email.to_s.gsub(/@.*/, '')
      end
      return ''
    end

  end
end