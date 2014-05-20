class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to = ENV['MAIL_TO']
  end
end

