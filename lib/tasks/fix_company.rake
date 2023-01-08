desc "Fix the live site error on login"
task fix_company: :environment do

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  user = User.fifth
  company = Company.new(name: "Centurion")
  if company.save
    puts "comany created successfully"
  end
  user.company = company
  if user.save
    puts "company asssigned successfully"
  end


  projects = Project.where(company_id: User.fifth.id)
  company = Company.last
  projects.each do |project|
    project.company = company
    if project.save
      puts "company id updated"
    else
      puts "something wrong"
    end
  end

end