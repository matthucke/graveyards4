

if Rails.env.development?
    (1..250).each do |ip|
      BetterErrors::Middleware.allow_ip! "192.168.1.#{ip}"
    end
end


