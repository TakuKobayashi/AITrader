# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
set :output, "#{path}/log/cron.log"

every AiBrain::HEALTH_CHECK_SPAN do
  runner "AiBrain.trace!"
end

every AiBrain::IMPORT_TICKER_SPAN do
  runner "Batch.import_ticker!"
end

every AiBrain::SHORT_IMAGINE_SPAN do
  runner "Batch.imagaine_routine!"
end