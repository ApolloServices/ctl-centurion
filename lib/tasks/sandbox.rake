desc 'Run rake tasks with sandboxing'
task sandbox: :environment do

  # Start transaction
  ActiveRecord::Base.connection.begin_transaction(joinable: false)
  puts "🆒 Sandbox Mode: ON 🆒"

  # Run your task
  Rake.application.invoke_task(ARGV.delete_at(1))

  # Teardown
  at_exit do
    puts "Rolling back......"
    ActiveRecord::Base.connection.rollback_transaction
    puts "Roll back complete...."
  end
end
