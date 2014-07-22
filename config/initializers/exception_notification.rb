if Rails.env.production?
  Puzzlenode::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[Puzzlenode] ",
    :sender_address => %{"Puzzlenode Notifier" <notifier@puzzlenode.com>},
    :exception_recipients => %w{jordan.byron@gmail.com puzzlenode@gmail.com},
    :ignore_crawlers      => %w{EasouSpider}
end
